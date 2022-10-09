// ignore_for_file: prefer_const_constructors, unused_import


////////////////////////////////////////   final //////////////////////////////////////


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/login_controller.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'screens/doctor_profile.dart';
import 'screens/doctor_search.dart';
import 'screens/doctor_favorit.dart';
import 'screens/doctor.dart';
import 'screens/patient.dart';
import 'screens/patient_favorit.dart';
import 'screens/patient_main.dart';
import 'screens/patient_profile.dart';
import 'screens/patient_search.dart';



//convex_bottom_bar


 Future <void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  
  
 Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }



}



//////////////////////////////////// map //////////////////////////////////////////
