// ignore_for_file: prefer_const_constructors, unnecessary_this, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/patient_record.dart';



class SerchDoctorScreen extends StatefulWidget {
  const SerchDoctorScreen({Key? key,}) : super(key: key);


  @override
  _SerchDoctorScreenState createState() => _SerchDoctorScreenState();
}

class _SerchDoctorScreenState extends State<SerchDoctorScreen> {
  String search = "";

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel(about: '', phone: '');

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
    
    Stream<QuerySnapshot> _bookingStream = FirebaseFirestore.instance
        .collection('bookingtrue')
        .where('uidD', isEqualTo: "${loggedInUser.uid}")
        .snapshots();


    return Scaffold(
           appBar: AppBar(
        title: Text("appoinment"),
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
                    height: 200,
                      key: Key(index.toString()),


/*
 child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
             ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
 ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
 
         
          ],
        ),
      ),
*/

                      
                      child: Card(

  color: Color.fromARGB(255, 206, 225, 250),

        

 shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),

    ),
                         child: Column(
          children: <Widget>[
            
/*
            CircleAvatar(
                backgroundImage: NetworkImage(""),
                radius: 50,
              ),
                  */    




                       ListTile(
              leading: Icon(Icons.account_circle),
              title: Text((documentSnapshot != null) ? (documentSnapshot["pname"]): ""),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, size: 40),
                            color: Color.fromARGB(255, 9, 104, 247),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecordPatientScreen(
                                    id: snapshot.data!.docChanges[index].doc['id'],
                                    name: snapshot.data!.docChanges[index].doc['pname'],
                                    date: snapshot.data!.docChanges[index].doc['date'],
                                    time: snapshot.data!.docChanges[index].doc['time'],




                             
                                  ),
                                ),
                              );


                            },


                          ),



            ),
      
        ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text((documentSnapshot != null) ? (documentSnapshot["date"]): ""),
            ),

             ListTile(
              leading: Icon(Icons.timer),
              title: Text((documentSnapshot != null) ? (documentSnapshot["time"]): ""),
            ),

          
                      
                      
                      
                      
                             ],
                      ),         
                      ),
                
                  
                      
                   
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

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
