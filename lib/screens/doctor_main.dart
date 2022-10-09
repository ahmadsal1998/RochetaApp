// ignore_for_file: prefer_const_constructors, unnecessary_this, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/booking_model.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/login_screen.dart';

class MainnDoctorScreen extends StatefulWidget {
  //MainnDoctorScreen
  const MainnDoctorScreen({Key? key}) : super(key: key);

  @override
  _MainnDoctorScreenState createState() => _MainnDoctorScreenState();
}

class _MainnDoctorScreenState extends State<MainnDoctorScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel(about: '', phone: '');
  BookingModel boo = BookingModel();

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
    }).whenComplete(() {
      CircularProgressIndicator();
    });
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _bookingStream = FirebaseFirestore.instance
        .collection('booking')
        .where('uidD', isEqualTo: "${loggedInUser.uid}")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
        centerTitle: true,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _bookingStream,
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

                  return Container(
                    height: 80,
                      key: Key(index.toString()),
                      child: Card(

                          child: Column(
          children: <Widget>[

                         ListTile(
                          title: Text((documentSnapshot != null)
                              ? (documentSnapshot["pname"])
                              : "",
                                style: TextStyle(fontWeight: FontWeight.bold),

                              ),

                          subtitle: Text(

                         "${  (documentSnapshot != null)? ((documentSnapshot["date"] != null)? documentSnapshot["date"]: ""): "" }"
                          " ["
                         "${  (documentSnapshot != null)? ((documentSnapshot["time"] != null)? documentSnapshot["time"]: ""): "" }"
                          " ]"
                         ,
                              
        
                              
                            style: TextStyle(color: Colors.red),

                              ),
                          trailing: SizedBox(
                            width: 150,
                            child: Row(
                                // mainAxisSize: MainAxisSize.min,

                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.done, size: 40),
                                    color: Color.fromARGB(255, 9, 104, 247),
                                    onPressed: () {
                                      setState(() {
                                        DocumentReference documentReference =
                                            FirebaseFirestore.instance
                                                .collection('bookingtrue')
                                                .doc();
                                        documentReference.set({
                                          "price": 0.0.toDouble(),
                                          "Diagnosis": "Diagnosis",
                                          "Medicine": "Medicine",
                                          "X-ray_name": "X-ray_name",
                                          "Notes": "Notes",
                                          "dname": ((documentSnapshot != null)
                                              ? (documentSnapshot["dname"])
                                              : ""),
                                          "pname": ((documentSnapshot != null)
                                              ? (documentSnapshot["pname"])
                                              : ""),
                                          "uidD": ((documentSnapshot != null)
                                              ? (documentSnapshot["uidD"])
                                              : ""),
                                          "uidP": ((documentSnapshot != null)
                                              ? (documentSnapshot["uidP"])
                                              : ""),
                                          "value": "0",
                                          "date": ((documentSnapshot != null)
                                              ? (documentSnapshot["date"])
                                              : ""),
                                          "time": ((documentSnapshot != null)
                                              ? (documentSnapshot["time"])
                                              : ""),
                                          "del": ((documentSnapshot != null)
                                              ? (documentSnapshot["del"])
                                              : ""),
                                          "id": documentReference.id.toString(),
                                        });

                                        FirebaseFirestore.instance
                                            .collection("booking")
                                            .doc((documentSnapshot != null)
                                                ? (documentSnapshot["id"])
                                                : "")
                                            .delete();
                                        FirebaseFirestore.instance
                                            .collection("Time")
                                            .doc(documentSnapshot!["del"])
                                            .delete();
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.cancel,
                                      size: 40,
                                    ),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        FirebaseFirestore.instance
                                            .collection("booking")
                                            .doc((documentSnapshot != null)
                                                ? (documentSnapshot["id"])
                                                : "")
                                            .delete();
                                      });
                                    },
                                  ),
                                ]),
                          ),
                        ),







],
                      ),


                      )
                      
                      );

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
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
