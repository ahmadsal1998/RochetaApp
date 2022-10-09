// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/patient.dart';
import 'package:intl/intl.dart';
import 'dart:async';



class DateBooking extends StatefulWidget {
  final String id;
  final String name;

  const DateBooking({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _DateBookingState createState() => _DateBookingState();
}

class _DateBookingState extends State<DateBooking> {
  TextEditingController dateController = TextEditingController();

  String? t;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  bookingfun() async {
    try {
      DocumentReference documentReference =FirebaseFirestore.instance.collection('booking').doc();

      documentReference.set({
        "uidD": widget.id,
        "uidP": "${loggedInUser.uid}",
        "pname": "${loggedInUser.firstName}${" "}${loggedInUser.secondName}",
        "dname": widget.name,
        "price": 0.0.toDouble(),
        "Diagnosis": "Diagnosis",
        "Medicine": "Medicine",
        "X-ray_name": "X-ray_name",
        "Notes": "Notes",
        "time": t,
        "date": dateController.text,
        "del": "${widget.id}" "${dateController.text}" "$t",
        "id": documentReference.id.toString(),
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateField = TextField(
      onChanged: (value) {
        //dateController.text= timemod.value??"";
      },
      keyboardType: TextInputType.multiline,
      maxLines: 1,
      controller: dateController,
      decoration: InputDecoration(
        labelText: "${loggedInUser.date}",
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        DateTime? pickeddate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        );

        if (pickeddate != null) {
          setState(() {
            dateController.text = DateFormat('yyyy-MM-dd').format(pickeddate);
          });
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking date"),
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Patient(
                          id: '',
                        )));
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName:
                  Text("${loggedInUser.firstName}${loggedInUser.secondName}"),
              accountEmail: Text("${loggedInUser.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(""),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("About"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.grid_3x3_outlined),
              title: Text("Products"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text("Contact"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("logout"),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),



      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Please choise a time",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              dateField,
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: (dateController.text != "")
                        
                    ? FirebaseFirestore.instance
                        .collection('Time')
                        .where('id',
                            isEqualTo: "${widget.id}" "${dateController.text}")
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Time')
                        .where('id',
                            isEqualTo: "${widget.id}" "${dateController.text}")
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          QueryDocumentSnapshot<Object?>? documentSnapshot =
                              snapshot.data?.docs[index];

                          return Dismissible(
                              key: Key(index.toString()),
                              child: Card(
                                elevation: 4,
                                child: ListTile(
                                  title: Text((documentSnapshot != null)
                                      ? (documentSnapshot["value"])
                                      : ""),
                                  subtitle: Text((documentSnapshot != null)
                                      ? ((documentSnapshot["value"] != null)
                                          ? documentSnapshot["value"]
                                          : "")
                                      : ""),
                                  onTap: () {
                                    t = snapshot
                                        .data!.docChanges[index].doc['value'];

                                  },
                                ),
                              ));
                        });
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
/////////////////////bookingfun();

                  bookingfun();
                },
                child: Text("Save"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  minimumSize: Size(220, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
