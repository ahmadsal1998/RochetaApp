// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/patient.dart';
import 'package:flutter_application_1/screens/profiles_doctor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';






class MainPatientScreen extends StatefulWidget { //MainPatientScreen

  final String x;

   MainPatientScreen({Key? key, required this.x}) : super(key: key);


  

  @override
  _MainPatientScreenState createState() => _MainPatientScreenState();
}



class _MainPatientScreenState extends State<MainPatientScreen> {

  String? t;

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

    return Scaffold(

      


      appBar: AppBar(
     title: Text("Doctors" " "  "${widget.x}"),
     centerTitle: true,
leading: BackButton(
            color: Colors.white,
            onPressed: (){
         

        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          Patient(id: '',)));
            },
        ),

      

      ),





body: StreamBuilder<QuerySnapshot>(
  


        stream:   FirebaseFirestore.instance

      .collection('users')
      .where('Specialization', isEqualTo: widget.x)
          //  .where('wrool', isEqualTo: 'pediatrician')

      .snapshots(),

        builder: (context, snapshot) {
          
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?>? documentSnapshot =snapshot.data?.docs[index];
                


                    return Container(
                    height: 300,
                      key: Key(index.toString()),

                      child: Card(
                        elevation: 4,
                                                 child: Column(

                                  children: <Widget>[

                    ListTile(
                                    leading: Icon(Icons.person),

                          title: Text((documentSnapshot != null) ? (documentSnapshot["name"]) : ""),
                

                                onTap: () {


                    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  ProfilesDoctorScreen(
 id: snapshot.data!.docChanges[index].doc['uid'],
 name:snapshot.data!.docChanges[index].doc['firstName'],
 specialization:snapshot.data!.docChanges[index].doc['Specialization'],
 about:snapshot.data!.docChanges[index].doc['about'],
 address:snapshot.data!.docChanges[index].doc['address'],
 phone:snapshot.data!.docChanges[index].doc['phone'],
  latitude:snapshot.data!.docChanges[index].doc['latitude'],
    longitude:snapshot.data!.docChanges[index].doc['longitude'],


              
              ),
          ),
                    );
                                  


                  },


                         
                        ),

   ListTile(
                                    leading: Icon(Icons.location_on ),

                          title: Text((documentSnapshot != null) ? (documentSnapshot["address"]) : ""),
                

                                onTap: () {


                    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  ProfilesDoctorScreen(
 id: snapshot.data!.docChanges[index].doc['uid'],
 name:snapshot.data!.docChanges[index].doc['firstName'],
 specialization:snapshot.data!.docChanges[index].doc['Specialization'],
 about:snapshot.data!.docChanges[index].doc['about'],
 address:snapshot.data!.docChanges[index].doc['address'],
 phone:snapshot.data!.docChanges[index].doc['phone'],
  latitude:snapshot.data!.docChanges[index].doc['latitude'],
    longitude:snapshot.data!.docChanges[index].doc['longitude'],


              
              ),
          ),
                    );
                                  


                  },


                         
                        ),



   ListTile(
                                    leading: Icon(Icons.medical_services_outlined  ),

                          title: Text((documentSnapshot != null) ? (documentSnapshot["Specialization"]) : ""),
                

                                onTap: () {


                    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  ProfilesDoctorScreen(
 id: snapshot.data!.docChanges[index].doc['uid'],
 name:snapshot.data!.docChanges[index].doc['firstName'],
 specialization:snapshot.data!.docChanges[index].doc['Specialization'],
 about:snapshot.data!.docChanges[index].doc['about'],
 address:snapshot.data!.docChanges[index].doc['address'],
 phone:snapshot.data!.docChanges[index].doc['phone'],
  latitude:snapshot.data!.docChanges[index].doc['latitude'],
    longitude:snapshot.data!.docChanges[index].doc['longitude'],


              
              ),
          ),
                    );
                                  


                  },


                         
                        ),


RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        //_ratingValue = value;
                      });
}),
                        
],
                      ),
                      ));
                
                
                
               
               
               
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

Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));


}
}