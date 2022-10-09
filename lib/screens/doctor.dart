// ignore_for_file: prefer_const_constructors, unnecessary_this, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/doctor_main.dart';
import 'doctor_profile.dart';
import 'doctor_search.dart';
import 'doctor_favorit.dart';
import 'doctor_main.dart';






class Doctor extends StatefulWidget { 
  
  String id;
  Doctor({Key? key, required this.id}) : super(key: key);

  @override
  _DoctorState createState() => _DoctorState(id:id);
}



class _DoctorState extends State<Doctor> {

  String id;
  var rooll;
  var emaill;


User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
    _DoctorState({required this.id});


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
      setState(() {
        emaill = loggedInUser.email.toString();
        rooll = loggedInUser.wrool.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }



  
  int selectedpage =0;
  final _pageOption=[FavDoctorScreen(),ProfileDoctorScreen(),MainnDoctorScreen(),SerchDoctorScreen()];

    



  @override
  Widget build(BuildContext context) {
    return Scaffold(


body: _pageOption[selectedpage],
bottomNavigationBar: ConvexAppBar(
  items: const [
    
     TabItem(icon: Icons.file_copy_sharp,title: "records"),
         TabItem(icon: Icons.person,title: "profile"),

    TabItem(icon: Icons.checklist,title: "reservations"),
   
    TabItem(icon: Icons.add_alert_sharp,title: "appointment"),
    

  ],

  initialActiveIndex: selectedpage,
  onTap: (int index){
    setState(() {
      selectedpage= index;
    });
  },


),
      
    );
  }

  

}