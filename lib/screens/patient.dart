// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/patient_favorit.dart';
import 'package:flutter_application_1/screens/patient_main%20copy.dart';
import 'package:flutter_application_1/screens/patient_main.dart';
import 'package:flutter_application_1/screens/patient_profile.dart';
import 'package:flutter_application_1/screens/patient_search.dart';
import 'package:flutter_application_1/screens/profiles_doctor.dart';


import 'patient_profile.dart';
import 'patient_search.dart';
import 'patient_favorit.dart';
import 'patient_main.dart';



class Patient extends StatefulWidget { //Patient
  
  String? id;
  Patient({Key? key, required this.id}) : super(key: key);

  @override
  _PatientState createState() => _PatientState(id:id);
}






class _PatientState extends State<Patient> {

  String? id;
  var rooll;
  var emaill;



User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
    _PatientState({required this.id});


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
  final _pageOption=[
        FavPatientScreen(),

    ProfilePatientScreen(),
    majors(),
    SerchPatientScreen(),
    
    ProfilesDoctorScreen(id: " ",name: " ", specialization: '', about: '', address: '', phone: '', latitude: 0.0, longitude: 0.0, )];

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: _pageOption[selectedpage],
bottomNavigationBar: ConvexAppBar(
  items: const [
    TabItem(icon: Icons.calendar_month,title: "appointmet"),
        TabItem(icon: Icons.person,title: "profile",),

    TabItem(icon: Icons.photo_camera_front_sharp,title: "Doctors"),
    TabItem(icon: Icons.file_copy_sharp,title: "My Record"),
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