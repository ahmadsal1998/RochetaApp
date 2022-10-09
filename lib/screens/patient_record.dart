// ignore_for_file: prefer_const_constructors, unnecessary_this, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/bookingtrue.dart';
import 'package:flutter_application_1/model/mymap.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/doctor.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/patient.dart';

//RecordPatientScreen

class RecordPatientScreen extends StatefulWidget {
  //ProfilesDoctorScreen
  final String id;
    final String name;
  final String date;
  final String time;


  const RecordPatientScreen({
    Key? key,
    required this.id, required this.name, required this.date, required this.time,
  }) : super(key: key);

  @override
  _RecordPatientScreenState createState() => _RecordPatientScreenState();
}

class _RecordPatientScreenState extends State<RecordPatientScreen> {
///////////////////////////////////////////////////////////////////////////////////
  TextEditingController nameController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController xrayController = TextEditingController();
  TextEditingController priceController = TextEditingController();
//TextEditingController phoneController=  TextEditingController() ;

////////////////////////////////////////////////////////////////////////////////////
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  BookingtModel bootrue = BookingtModel();

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
        .collection("bookingtrue")
        .doc(widget.id)
        .get()
        .then((value) {
      this.bootrue = BookingtModel.fromMap(value.data());
      setState(() {});
    });

  }


  bookingfun() async {
    try {
      await FirebaseFirestore.instance
          .collection('bookingtrue')
          .doc(widget.id)/////////////edit
          .set({
     
        "price": double.parse(priceController.text.toString()),
        "Diagnosis": diagnosisController.text,
        "Medicine": medicineController.text,
        "X-ray_name": xrayController.text,
        "Notes": notesController.text,
  
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = bootrue.pname ?? "";
    final nameField = TextField(
      enabled: false,
      keyboardType: TextInputType.multiline,
      maxLines: 1,
      onChanged: (value) {
        bootrue.pname = nameController.text;
      },
      controller: nameController,
      decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
          ),
          border: OutlineInputBorder(),
          labelText: 'pattient name',
          labelStyle: TextStyle(
            color: Colors.red,
          )),
    );

    diagnosisController.text = bootrue.Diagnosis ?? ""; ///////////////////
    final diagnosisField = TextField(
      ////////////////////////////

      //enabled: false,

      keyboardType: TextInputType.multiline,
      maxLines: 4,
      onChanged: (value) {
        bootrue.Diagnosis = diagnosisController.text; //////////////////////////
      },

      controller: diagnosisController, ///////////////

      decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
          ),
          border: OutlineInputBorder(),
          labelText: 'diagnosis',
          labelStyle: TextStyle(
            color: Colors.red,
          )),
    );

    medicineController.text = bootrue.Medicine ?? ""; ///////////////////
    final medicineField = TextField(
      ////////////////////////////

      //enabled: false,

      keyboardType: TextInputType.multiline,
      maxLines: 1,
      onChanged: (value) {
        bootrue.Medicine = medicineController.text; //////////////////////////
      },

      controller: medicineController, ///////////////

      decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
          ),
          border: OutlineInputBorder(),
          labelText: 'medicine',
          labelStyle: TextStyle(
            color: Colors.red,
          )),
    );

    notesController.text = bootrue.Notes ?? ""; ///////////////////
    final notesField = TextField(
      ////////////////////////////

      //enabled: false,

      keyboardType: TextInputType.multiline,
      maxLines: 1,
      onChanged: (value) {
        bootrue.Notes = notesController.text; //////////////////////////
      },

      controller: notesController, ///////////////

      decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
          ),
          border: OutlineInputBorder(),
          labelText: 'Notes',
          labelStyle: TextStyle(
            color: Colors.red,
          )),
    );

    xrayController.text = bootrue.X_ray_name ?? ""; ///////////////////
    final xrayField = TextField(
      ////////////////////////////

      //enabled: false,

      keyboardType: TextInputType.multiline,
      maxLines: 1,
      onChanged: (value) {
        bootrue.X_ray_name = xrayController.text; //////////////////////////
      },

      controller: xrayController, ///////////////

      decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
          ),
          border: OutlineInputBorder(),
          labelText: 'X-RAY',
          labelStyle: TextStyle(
            color: Colors.red,
          )),
    );

//priceController.text="bootrue.price";///////////////////
    priceController.text = bootrue.price.toString(); ///////////////////

    final priceField = TextField(
      ////////////////////////////

      //enabled: false,

      maxLines: 1,
      onSubmitted: (value) {
        setState(() {
          bootrue.price = double.parse(priceController.text)
              .toDouble(); //////////////////////////
        });
      },

      controller: priceController, ///////////////
      keyboardType: TextInputType.number,

      decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
          ),
          border: OutlineInputBorder(),
          labelText: 'price',
          labelStyle: TextStyle(
            color: Colors.red,
          )),
    );

////////////////////////////////////////////////////////

    /*
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
      

      ),
      



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
           
                  SizedBox(height: 30,),


 CircleAvatar(
 
                  backgroundImage:  NetworkImage("${loggedInUser.imageurl}"),

         

                  radius: 80,
                ),






                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                  Text("doctor:    "),

                 Text(widget.id),


                  ],),
                  SizedBox(height: 30,),
/*

SizedBox(height: 10,),
 Text(widget.name),

SizedBox(height: 10,),
 Text(widget.specialization),

SizedBox(height: 10,),
 Text(widget.about),

SizedBox(height: 10,),
Text(widget.address),

SizedBox(height: 10,),
Text(widget.phone),

SizedBox(height: 10,),

*/



Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                  Text("uuser:    "),
                  Text("${loggedInUser.name}"),

                  ],),

                       Expanded(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('location').snapshots(),
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
          )),

                

                  
            SizedBox(height: 30,),
          //   loginButton,
                  SizedBox(height:30 ),
                  TextButton(
  onPressed: () {

/*
     Map <String,dynamic> data = {
       "uidD":widget.id,
       "uidP":"${loggedInUser.uid}",
       "pname":"${loggedInUser.firstName}${loggedInUser.secondName}",
       "dname":widget.name,
       


     };
       FirebaseFirestore.instance.collection("booking").add(data);
*/

bookingfun();





  },
  child: Text("BUTTON"),
),
              
 TextField(
  
   enabled: false,
   
  
    keyboardType: TextInputType.multiline,
  maxLines: 1 ,
onChanged: (value){

//loggedInUser.address=addressController.text;
},
     
               //   controller: addressController,
 controller:TextEditingController()..text = widget.name,
    


                  decoration: InputDecoration(
                    
                    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 10, color: Colors.greenAccent), //<-- SEE HERE
    ),
                    border: OutlineInputBorder(),
                    labelText: 'address',
                    
                    
                  ),

                ),
                  

TextField(
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 3, color: Colors.greenAccent),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 3, color: Color(0xffF02E65)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 3, color: Color.fromARGB(255, 66, 125, 145)),
    ),
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



    */


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Doctor(
                          id: '',
                        )));
          },
        ),

      ),

      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName:
                  Text("${loggedInUser.firstName}${loggedInUser.secondName}"),
              accountEmail: Text("${loggedInUser.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(""),
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
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ColoredBox(
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //mainAxisSize: MainAxisSize.max,
                        children:  <Widget>[
                          Text(
                          " ${ widget.date}",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " ${ widget.time}",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    nameField,

                    SizedBox(height: 20),
                    diagnosisField,
             
                    SizedBox(height: 20),
                        medicineField,
          
                    SizedBox(height: 20),
                    notesField,
             
                    SizedBox(height: 20),
                    xrayField,

                    SizedBox(height: 20),

                    priceField,

                    SizedBox(height: 25),

                    TextButton(
                      onPressed: () {
                        bookingfun();
                      },
                      child: Text("Save"),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        minimumSize: Size(220, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
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
