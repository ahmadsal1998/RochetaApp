import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/doctor.dart';
import 'package:flutter_application_1/screens/patient.dart';

class Routing extends StatefulWidget {
  const Routing({Key? key}) : super(key: key);
//Routing
  @override
  _RoutingState createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  _RoutingState();
  @override
  Widget build(BuildContext context) {
    return const Contro();
  }
}

class Contro extends StatefulWidget {
    const Contro({Key? key}) : super(key: key);


  @override
  _ControState createState() => _ControState();
}

class _ControState extends State<Contro> {
  _ControState();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel(about: '', phone: '');
  var rooll;
  var emaill;
  var id;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        rooll = loggedInUser.wrool.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  routing() {
    if (rooll == 'Doctor') {//Student
      return Doctor(
        id: id,
      );
    } else {
      return Patient(
        id: id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const CircularProgressIndicator();
    return routing();
  }
}

//Patient