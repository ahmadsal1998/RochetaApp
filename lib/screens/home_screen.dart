// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/login_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
     title: Text("Welcome"),
     centerTitle: true,


      ),

     body: Center(
     
     child: Padding(
       
       padding: EdgeInsets.all(20),
       child: Column(

         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[

           SizedBox(
             height: 150,
            child:  Image.asset("assets/2.jpg",fit: BoxFit.contain),
           ),
            Text(
              "Hello Doctor",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),

  SizedBox(
                height: 10,
                ),
               Text(
              "Account created"
               ,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 10,
                ),
              Text("amjad saleh",
            style: TextStyle(
color: Colors.black54,
              fontWeight: FontWeight.w500,
              
             ),
               ),

                 Text("amjadsaleh1@gmail.com",

                  style: TextStyle(
                color: Colors.black54,
              fontWeight: FontWeight.w500,
              
              ),
                ),
                  
                  SizedBox(

                      height: 15,

                  ),

                  ActionChip(label: Text("Logout"), onPressed: () {

                      logout(context);

                  }),
                  
         ],

       ),
  
     
     ),

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