// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_print, unused_import


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/login_controller.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/doctor.dart';
import 'package:flutter_application_1/screens/patient.dart';
import 'package:flutter_application_1/screens/registration_screen.dart';
import 'package:flutter_application_1/screens/routing.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  //from key

final _formKey = GlobalKey<FormState>();





  //editing controller
  
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  
  //firebase
  
  final _auth = FirebaseAuth.instance;
    String? errorMessage;

  
  
  @override
  Widget build(BuildContext context) {


    
   
   
    return Scaffold(
   
      appBar: AppBar(
        title: Text("My Doctor"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

     backgroundColor: Colors.white,
     body: loginUI(),
     


      

    );



  }


  loginUI() {
    // loggedINUI
    // loginControllers

    return Consumer<LoginController>(builder: (context, model, child) {
      // if we are already logged in
      if (model.userDetails != null) {
        return Center(
          child: Routing(),
        );
      } else {
        return loginControllers(context);
      }
    });
  }

  loginControllers(BuildContext context) {



//email field

   final emailField = TextFormField(

   autofocus: false,
   controller: emailController,
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
     emailController.text = value!;
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
   

   //password field

   final passwordField = TextFormField(

   autofocus: false,
   controller: passwordController,
  
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
     passwordController.text = value!;
   },
   
   textInputAction: TextInputAction.done,

    decoration: InputDecoration(
     prefixIcon:  Icon(Icons.vpn_key),
     contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
     hintText: "Password",
     border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(10)

     ),
   ),

   );
   
   
   //LoginButton

   final loginButton = Material(

   elevation: 5,
   borderRadius: BorderRadius.circular(30),
   color: Colors.blue,
   child: MaterialButton(
     padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
     minWidth: MediaQuery.of(context).size.width,
     onPressed: () {

       //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

        signIn(emailController.text, passwordController.text);

     },
     child: Text(
       "LOGIN",
       textAlign: TextAlign.center,
       style: TextStyle(
         fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold
       ),
     ),
   
   
   ),


   );





   return Center(

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
                    height: 150,
                    child: Image.asset("assets/2.jpg",fit: BoxFit.contain,)
                  ),
                  SizedBox(height:10 ),
                  emailField,
                  SizedBox(height:30 ),
                  passwordField,
                  SizedBox(height:30 ),
                  loginButton,
                  SizedBox(height:30 ),
                  
                  

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("dont have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          RegistrationScreen()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                             fontSize: 15),
                             
                        ),




                      )
                    ] ),
///////////////////////////////////// facebok and google/////////////////////////////////////////
/*

                      GestureDetector(
              child: Image.asset(
                "assets/google.png",
                width: 240,
              ),
              onTap: () {
                Provider.of<LoginController>(context, listen: false)
                    .googleLogin();
              }),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              child: Image.asset(
                "assets/fb.png",
                width: 240,
              ),
              onTap: () {
                Provider.of<LoginController>(context, listen: false)
                    .facebooklogin();
              }),

*/
                  ],
                  ),
                  ),
          ),
         ),

       )
      );
  }


//login function

void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Routing())),
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


}





