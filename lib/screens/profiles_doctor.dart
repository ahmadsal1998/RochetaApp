// ignore_for_file: prefer_const_constructors, unnecessary_this, deprecated_member_use


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/mymap.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/date_booking.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/patient.dart';

import 'dart:async';










class ProfilesDoctorScreen extends StatefulWidget { //ProfilesDoctorScreen
final String id;

final String name;
final String specialization;
final String about;
final String address;
final double latitude;
final double longitude;
final String phone;





  const ProfilesDoctorScreen({Key? key,required this.id,required this.name, required this.specialization, required this.about, required this.address,required this.phone, required this.latitude, required this.longitude, }) : super(key: key);


  @override
  _ProfilesDoctorScreenState createState() => _ProfilesDoctorScreenState();
}



class _ProfilesDoctorScreenState extends State<ProfilesDoctorScreen> {








   //LoginButton

   





////////////////////////////////////////////////// table user ///////////////////////////////////////////
User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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



   
  }


bookingfun()async{


try {
  DocumentReference documentReference = FirebaseFirestore.instance.collection('booking').doc();    
documentReference.set({
  
   "uidD":widget.id,
       "uidP":"${loggedInUser.uid}",
       "pname":"${loggedInUser.firstName}${loggedInUser.secondName}",
       "dname":widget.name,
      "price":0.0.toDouble(),
      "Diagnosis":"Diagnosis",
      "Medicine":"Medicine",
      "X-ray_name":"X-ray_name",
      "Notes":"Notes",



        "id": documentReference.id.toString(),


  
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }

}




  @override
  Widget build(BuildContext context) {


 return Scaffold(

   appBar: AppBar(
     title: Text("Profile"),
     centerTitle: true,

leading: BackButton(
            color: Colors.white,
            onPressed: (){
         

        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          Patient(id: '',)));
            },
        ),

       actions: [
    IconButton(
      onPressed: () {

    Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MyMap(widget.id)));


      },
      icon: Icon(Icons.map),
    ),
       ],
      

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


    //  MAP
/*
             body: Column(
        children: [
        
         
          TextButton(
              onPressed: () {
                _getLocation();
              },
              child: Text('add my locatio')),
         
         
         
          TextButton(
              onPressed: () {
                _listenLocation();
              },
              child: Text('enable live location')),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: Text('stop live location')),
         
         
         
          Expanded(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('locatio').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['latitude']
                              .toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.directions),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MyMap(snapshot.data!.docs[index].id)));
                        },
                      ),

                      




                    );


                    
                  });
            },
          )
          
          
          
          
          
          
          
          
          
          
          ),
        ],
      ),  

*/


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


CircleAvatar(
 
                  backgroundImage:  NetworkImage("${loggedInUser.imageurl}"),

         

                  radius: 80,
                ),
              


        SizedBox(height: 15),
     TextField(

   enabled: false,
   
  
    keyboardType: TextInputType.multiline,
  maxLines: 1 ,

 controller:TextEditingController()..text = widget.name,
    

                  decoration: InputDecoration(


                    
                    disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),

    ),
                    border: OutlineInputBorder(),
                    labelText: 'dr_name',
                    labelStyle: TextStyle(
        color: Colors.red ,
        
      )
                    
                    
                  ),

                ),
                
        SizedBox(height: 15),

  TextField(

   enabled: false,
   
  
    keyboardType: TextInputType.multiline,
  maxLines: 1 ,

 controller:TextEditingController()..text = widget.phone,
    

                  decoration: InputDecoration(


                    
                    disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),

    ),
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                    labelStyle: TextStyle(
        color: Colors.red ,
        
      )
                    
                    
                  ),

                ),

        SizedBox(height: 15),
                      TextField(

   enabled: false,
   
  
    keyboardType: TextInputType.multiline,
  maxLines: 1 ,

 controller:TextEditingController()..text = widget.address,
    

                  decoration: InputDecoration(


                    
                    disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),

    ),
                    border: OutlineInputBorder(),
                    labelText: 'address',
                    labelStyle: TextStyle(
        color: Colors.red ,
        
      )
                    
                    
                  ),

                ),

        SizedBox(height: 15),
             TextField(

   enabled: false,
   
  
    keyboardType: TextInputType.multiline,
  maxLines: 4 ,

 controller:TextEditingController()..text = widget.about,
    

                  decoration: InputDecoration(


                    
                    disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),

    ),
                    border: OutlineInputBorder(),
                    labelText: 'about',
                    labelStyle: TextStyle(
        color: Colors.red ,
        
      )
                    
                    
                  ),

                ),


  
                  SizedBox(height: 25),







TextButton(
  onPressed: () {

//bookingfun();



                    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  DateBooking(
              id: widget.id,
              name:widget.name,

              
              ),
          ),
                    );











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