// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_field, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  _RegistrationScreenState(); ///////////////////////////////////////////////////////////////1

  bool showProgress = false;/////////////////////////////////////////////////////////////////2
  bool visible = false; /////////////////////////////////////////////////////////////////////3

  final _auth = FirebaseAuth.instance;
    String? errorMessage;


//our from key
final _formKey = GlobalKey<FormState>();
//editing controller
CollectionReference ref = FirebaseFirestore.instance.collection('users');////////////////////4
final  firstNameEditingController = new TextEditingController();
final  secondtNameEditingController = new TextEditingController();
final  emailEditingController = new TextEditingController();
final  passwordEditingController = new TextEditingController();
final  confirmPasswordEditingController = new TextEditingController();

/////////////////////////////////////// extra code /////////////////////////
 final bool _isObscure = true;
  final bool _isObscure2 = true;
  File? file;
////////////////////////////////////////////////////////////////////////////


  var options = ['Doctor','Patient',]; ///////////////////////////////////////////////////////5
  var _currentItemSelected = "Patient";/////////////////////////////////////////////////////6
  var rool = "Patient";///////////////////////////////////////////////////////////////////////7


  @override
  Widget build(BuildContext context) {
   //first name field
   final firstNameField = TextFormField(

   autofocus: false,
   controller: firstNameEditingController,
   keyboardType: TextInputType.name,

   validator: (value){

      RegExp regex = new RegExp(r'^.{3,}$');
      if(value!.isEmpty){

        return("first name can't be empty");

      }

        if(!regex.hasMatch(value))
        {
          return("please enter valid name (main. 3 character)");
        }
        return null;
    },
   onSaved: (value){
     firstNameEditingController.text = value!;
   },
   
   textInputAction: TextInputAction.next,

   
   decoration: InputDecoration(
     prefixIcon:  Icon(Icons.account_circle),
     contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
     hintText: "First Name",
     border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10)

     ),
   ),

   );

     //second name field
   final secondNameField = TextFormField(

   autofocus: false,
   controller: secondtNameEditingController,
   keyboardType: TextInputType.name,

    validator: (value){

      if(value!.isEmpty){

        return("first name can't be empty");

      }

    },

   onSaved: (value){
         secondtNameEditingController.text = value!;
   },
   
   textInputAction: TextInputAction.next,

   
   decoration: InputDecoration(
     prefixIcon:  Icon(Icons.account_circle),
     contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
     hintText: "second Name",
     border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10)

     ),
   ),

   );

   //emil field
   final emailField = TextFormField(

   autofocus: false,
   controller: emailEditingController,
   keyboardType: TextInputType.emailAddress,

    validator: (value){

     if(value!.isEmpty)
     {
       return ("please enter your email");
     }
      // reg expression for email validation
      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9..-]+.[a-z]").hasMatch(value))
      {
        return("plese enter a valid email");
      }
      return null;
   },


   onSaved: (value){
     emailEditingController.text = value!;
   },
   
   textInputAction: TextInputAction.next,

   
   decoration: InputDecoration(
     prefixIcon:  Icon(Icons.mail),
     contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
     hintText: "Email",
     border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10)

     ),
   ),

   );
   
   //roll
    

   //password field
   final passwordField = TextFormField(

   autofocus: false,
   controller: passwordEditingController,
  
   obscureText: true,

    validator: (value){

      RegExp regex = new RegExp(r'^.{6,}$');
      if(value!.isEmpty){

        return("Passsword is required for login");

      }

        if(!regex.hasMatch(value))
        {
          return("please enter valid password(main. 6 character)");
        }
    },

   onSaved: (value){
     passwordEditingController.text = value!;
   },
   
   textInputAction: TextInputAction.next,

   
   decoration: InputDecoration(
     prefixIcon:  Icon(Icons.vpn_key),
     contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
     hintText: "Password",
     border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10)

     ),
   ),

   );

   
   //confirm password field
   final confirmPasswordField = TextFormField(

   autofocus: false,
   controller: confirmPasswordEditingController,
  
   obscureText: true,

 validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
   onSaved: (value){
     confirmPasswordEditingController.text = value!;
   },
   
   textInputAction: TextInputAction.done,

   
   decoration: InputDecoration(
     prefixIcon:  Icon(Icons.vpn_key),
     contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
     hintText: "Confirm Password",
     border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10)

     ),
   ),

   );
    // roll

    


   //signup button

   final signUpButton = Material(

   elevation: 5,
   borderRadius: BorderRadius.circular(30),
   color: Colors.blue,
   child: MaterialButton(
     padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
     minWidth: MediaQuery.of(context).size.width,
     onPressed: () {
       signUp(emailEditingController.text, passwordEditingController.text,rool);
     },
     child: Text(
       "SingUp",
       textAlign: TextAlign.center,
       style: TextStyle(
         fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold
       ),
     ),
   
   
   ),


   );



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          
          icon: Icon(Icons.arrow_back,color: Colors.red),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },

        ),
      ) ,
   
     backgroundColor: Colors.white,
     body: Center(

       child: SingleChildScrollView(
         
         child: Container(
          color: Colors.white,
          child: Padding(padding: const EdgeInsets.all(36.0),
          
            child: Form(
                key: _formKey,
              child: Column(

                mainAxisAlignment:MainAxisAlignment.center ,
                crossAxisAlignment: CrossAxisAlignment.center,


                children: <Widget>[
                  SizedBox(
                    height: 180,
                    child: Image.asset("assets/2.jpg",fit: BoxFit.contain,)
                  ),
                    
                    // roll
                   Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Rool : ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 134, 102, 102),
                              ),
                            ),
                            DropdownButton<String>(
                              dropdownColor: Colors.blue[900],
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: Color.fromARGB(255, 150, 95, 95),
                              focusColor: Color.fromARGB(255, 0, 0, 0),
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 129, 59, 59),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  rool = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ],
                        ),



                  SizedBox(height:45 ),
                  firstNameField,
                  SizedBox(height:20 ),
                  secondNameField,
                  
                   SizedBox(height:20 ),
                  emailField,
                   SizedBox(height:20 ),
                  passwordField,
                   SizedBox(height:20 ),
                  confirmPasswordField,
                  SizedBox(height:20 ),
                  signUpButton,
                  SizedBox(height: 15)
                  
                  
                  
                  
                    ],
                     ),

                  
                  ),
                  ),
          ),
         ),

       ),
      


    );
  }


void signUp(String email, String password,String rool) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore(email,rool)})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore(String email, String rool) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel(about: '', phone: '');

    // writing all the values
    userModel.email = email;
    userModel.uid = user!.uid;
    userModel.wrool = rool;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondtNameEditingController.text;
    userModel.phone = "";



    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }









}