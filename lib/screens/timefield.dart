// ignore_for_file: prefer_const_constructors, unnecessary_this, deprecated_member_use


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/bookingtrue.dart';
import 'package:flutter_application_1/model/mymap.dart';
import 'package:flutter_application_1/model/time_model.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/doctor.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/patient.dart';




import 'dart:async';

import 'package:intl/intl.dart';





//RecordPatientScreen

class TimeField extends StatefulWidget { //ProfilesDoctorScreen




  const TimeField({Key? key,}) : super(key: key);


  @override
  _TimeFieldState createState() => _TimeFieldState();
}



class _TimeFieldState extends State<TimeField> {


TextEditingController dateController=  TextEditingController() ;
TextEditingController priceController=  TextEditingController() ;
TextEditingController priceController1=  TextEditingController() ;




User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  TimeModel timemod= TimeModel();

    final _formKey = GlobalKey<FormState>();


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



 super.initState();
    FirebaseFirestore.instance
        .collection("Time")
        .doc()
        .get()
        .then((value) {
      this.timemod = TimeModel.fromMap(value.data());
      setState(() {});
    
    });



  
  }




  bookingfun()async{
    int x =  int.parse(priceController.text).toInt();
    int y =  int.parse(priceController1.text).toInt();



for (int i =x; i < y; i++) {

try {
      await FirebaseFirestore.instance.collection('Time').doc("${loggedInUser.uid}" "${dateController.text}" "$i" "-" "${i+1}").set({
  
  //      "value":"$i" "-" ":",
  
      "value":"$i" "-" "${i+1}",
      "id":"${loggedInUser.uid}" "${dateController.text}" ,





  
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
}
}









  @override
  Widget build(BuildContext context) {

  //dateController.text=timemod.value??"";

   final dateField =  TextField(
  
  onChanged: (value){
 dateController.text= timemod.value??"";
  },
  
  
    keyboardType: TextInputType.multiline,
  maxLines: 1 ,

     
                  controller: dateController,
                    
                  decoration:  InputDecoration(

                  labelText: "${loggedInUser.date}",

                    border: OutlineInputBorder(),
                   
                    
                  ),

                  onTap:() async{ 
                    DateTime? pickeddate= await showDatePicker(
                    context: context,
                     initialDate: DateTime.now(), 
                     firstDate: DateTime(2000),
                      lastDate: DateTime(2050),
                      );

if(pickeddate!= null){
  setState(() {
    dateController.text =DateFormat('yyyy-MM-dd').format(pickeddate);


  });
}



                  },

                );

   final priceField =  TextField(////////////////////////////
  
  
     //enabled: false,

  maxLines: 1 ,
onSubmitted: (value){



},
     
                  controller: priceController,///////////////
                      keyboardType: TextInputType.number,



 decoration: InputDecoration(


                    
                    disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),

    ),
                    border: OutlineInputBorder(),
                    labelText: 'From',
                    labelStyle: TextStyle(
        color: Colors.red ,
        
      )
                    
                    
                  ),



                );


     final priceField1 =  TextField(////////////////////////////
  
  
     //enabled: false,

  maxLines: 1 ,
onSubmitted: (value){



},
     
                  controller: priceController1,///////////////
                      keyboardType: TextInputType.number,



 decoration: InputDecoration(


                    
                    disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),

    ),
                    border: OutlineInputBorder(),
                    labelText: 'TO',
                    labelStyle: TextStyle(
        color: Colors.red ,
        
      )
                    
                    
                  ),



                );

  
 return Scaffold(

   appBar: AppBar(
     title: Text("workdays"),
     centerTitle: true,

leading: BackButton(
            color: Colors.white,
            onPressed: (){
         

        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          Doctor(id: '',)));
            },
        ),

      
      ),


drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${loggedInUser.firstName}${loggedInUser.secondName}"),
              accountEmail: Text("${loggedInUser.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    ""),
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

              ColoredBox(
  color: Color.fromARGB(255, 255, 255, 255),

child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //mainAxisSize: MainAxisSize.max,
  children: const <Widget>[
    Text(
      "please choice work time",
      textAlign: TextAlign.left,
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
    ),

  ],
),
), 


        SizedBox(height: 20),
        dateField,

        SizedBox(height: 20),
        priceField,

        SizedBox(height: 20),
        priceField1,


        SizedBox(height: 20),

        SizedBox(height: 20),

        SizedBox(height: 20),
       
        SizedBox(height: 25),



TextButton(
  onPressed: () {

 bookingfun();

  },
  child: Text("Save"),

  style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  minimumSize: Size(220,50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),

),



],
),                     
),
),
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