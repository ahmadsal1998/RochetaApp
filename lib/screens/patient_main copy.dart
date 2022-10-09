// ignore_for_file: prefer_const_constructors, unnecessary_this, unnecessary_new, avoid_print, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/patient_main.dart';
import 'package:flutter_application_1/screens/profiles_doctor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';






class majors extends StatefulWidget { //MainPatientScreen

 


  

  @override
  _majorsState createState() => _majorsState();
}



class _majorsState extends State<majors> {

  String? t;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel(about: '', phone: '');

   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance

      .collection('users')
      .where('wrool', isEqualTo: 'Doctor')
      .snapshots();

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

    return Scaffold(

      


      appBar: AppBar(
     title: Text("Doctors"),
     centerTitle: true,


      

      ),





        body: Center(
          child: Container(
            // height: 200,
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              children: [
                Card(
                  child: new InkWell(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MainPatientScreen(
                                    x: "pediatrician",
                                  )));
                      },
                    child: Container(
                       child: Image.asset("assets/predic.png"),
                 
                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
                Card(
                  child: new InkWell(
               onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MainPatientScreen(
                                    x: "dentist ",
                                  )));
                      },
                    child: Container(
                       child: Image.asset("assets/dentist.png",)

              
                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
                Card(
                  child: new InkWell(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MainPatientScreen(
                                    x: "General Doctor",
                                  )));
                      
                      },
                    child: Container(
                                    child: Image.asset("assets/family.png"),

                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
                Card(
                  child: new InkWell(
                 onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MainPatientScreen(
                                    x: "Orthopedic Doctor",
                                  )));
                      
                      },
                    child: Container(
                                      child: Image.asset("assets/Orthopedic.png"),

                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
                Card(
                  child: new InkWell(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MainPatientScreen(
                                    x: "Internist",
                                  )));
                      },
                    child: Container(
                                       child: Image.asset("assets/int.png"),

                    ),
                  ),
                  color: Colors.blue,
                  
                  
                ),
               Card(
                  child: new InkWell(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MainPatientScreen(
                                    x: "neurologist",
                                  )));
                      },
                    child: Container(
                                        child: Image.asset("assets/neurologist.png"),

                    ),
                  ),
               
                  color: Colors.blue,
               )
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