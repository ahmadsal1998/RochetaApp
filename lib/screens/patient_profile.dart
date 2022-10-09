// ignore_for_file: prefer_const_constructors, unnecessary_this, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'dart:async';




class ProfilePatientScreen extends StatefulWidget { //ProfilePatientScreen
  const ProfilePatientScreen({ Key? key }) : super(key: key);

  @override
  _ProfilePatientScreenState createState() => _ProfilePatientScreenState();
}

class _ProfilePatientScreenState extends State<ProfilePatientScreen> {
  
  File? _image;
  String? _url;




  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  final _formKey = GlobalKey<FormState>();


TextEditingController img=  TextEditingController() ;

TextEditingController nameController=  TextEditingController() ;

TextEditingController phoneController=  TextEditingController() ;

TextEditingController addressController=  TextEditingController() ;

TextEditingController aboutController=  TextEditingController() ;

TextEditingController dateController=  TextEditingController() ;



User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
   ///////////////////////////////////// DoctorModel doctordata = DoctorModel();

  


  @override
  void initState() {
    super.initState();



    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });





  }



final TextEditingController dropcontroller = TextEditingController();
  var items = ['A+ ', 'A- ', 'O+', 'O-', 'B+', 'B-'];



  bookingfun()async{

try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('users').doc("${loggedInUser.uid}").set({
  "email":loggedInUser.email,
  "firstName":loggedInUser.firstName,
  "secondName":loggedInUser.secondName,
  "uid":loggedInUser.uid,
  "wrool":loggedInUser.wrool,
  'latitude': _locationResult.latitude,
  'longitude': _locationResult.longitude,
  
  'name':nameController.text,

  "phone":phoneController.text,

  "address":addressController.text,

  "about":aboutController.text,

  'imageurl':_url,
  'bold':dropcontroller.text,

  'date':dateController.text,

  
  
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }

}

  @override
  Widget build(BuildContext context) {



   aboutController.text=loggedInUser.about??"";
   addressController.text=loggedInUser.address??"";
   phoneController.text=loggedInUser.phone??"";
   nameController.text=loggedInUser.name??"";
   dropcontroller.text=loggedInUser.specialization??"";
   nameController.text=loggedInUser.name??"";
  
  /* 
    //about field
final aboutField =  TextField(
  
  
  
    keyboardType: TextInputType.multiline,
  maxLines: 1 ,
onChanged: (value){

loggedInUser.about=aboutController.text;
},
     
                  controller: aboutController,
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    labelText: 'about',
                    
                  ),

                );

                */
    //address field
final addressField =  TextField(
  
  
  
    keyboardType: TextInputType.multiline,
  maxLines: 1 ,
onChanged: (value){

loggedInUser.address=addressController.text;
},
     
                  controller: addressController,
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    labelText: 'address',
                    
                  ),

                );




                
    //phone field
final phoneField =  TextField(
  
  
  
    keyboardType: TextInputType.multiline,
  maxLines: 1 ,
onChanged: (value){

loggedInUser.phone=phoneController.text;
},
     
                  controller: phoneController,
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    labelText: 'phone',
                    
                  ),

                );




//name field
final nameField =  TextField(
  
  
  
    keyboardType: TextInputType.multiline,
  maxLines: 1 ,
onChanged: (value){
 // nameController.text="${loggedInUser.firstName}" " " "${loggedInUser.secondName}";

loggedInUser.name=nameController.text;
//nameController.text="${loggedInUser.firstName}" " " "${loggedInUser.secondName}";
},
     
                  controller: nameController,
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    labelText: 'name',
                    
                  ),

                );
//date field
final dateField =  TextField(
  
  onChanged: (value){
 dateController.text= loggedInUser.date??"";
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
                     firstDate: DateTime(1990),
                      lastDate: DateTime(2050),
                      );

if(pickeddate!= null){
  setState(() {
    dateController.text =DateFormat('yyyy-MM-dd').format(pickeddate);


  });
}



                  },

                );

    return Scaffold(

   appBar: AppBar(
     title: Text("Profile"),
     centerTitle: true,


      

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


/*        MAP

             body: Column(
        children: [
        
         
          TextButton(
              onPressed: () {
                _getLocation();
              },
              child: Text('add my locatio')),
         
         
         /*
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
         
         */
         
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

                  
       Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 GestureDetector(onTap: pickImage, child: Icon(Icons.camera_alt)),

                         CircleAvatar(
                  foregroundImage: _image == null ? null : FileImage(_image!),
                  backgroundImage:  NetworkImage("${loggedInUser.imageurl}"),

         

                  radius: 80,
                ),

                 
              
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      uploadImage(context);
                    },
                    child: Icon(Icons.save)
                   // child: Text('Upload Image'),
                  ),


                ),

              
            ],
            
    
            
            ),


        

        SizedBox(height: 15),
                  nameField,

        SizedBox(height: 15),
                  phoneField,

        SizedBox(height: 15),
                  dateField,

        SizedBox(height: 15),
                addressField,
              
       SizedBox(height: 15),
              //    aboutField,
       SizedBox(height: 15),



             Column(

          
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(


                        child: TextField(
                          enabled: false,
                          controller: dropcontroller,

                          decoration: InputDecoration(
                    
                   border: OutlineInputBorder(),
                    labelText: 'bold type',
                    
                  
                  ),
                          
                          )
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          dropcontroller.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return items.map<PopupMenuItem<String>>((String value) {
                            return PopupMenuItem(child: Text(value), value: value);
                          }).toList();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
         
                  SizedBox(height: 15),

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


   // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<void> pickImage() async {
        final ImagePicker image = ImagePicker();

     var imagee = await image.pickImage(source: ImageSource.camera);

    setState(() {
      _image =File(imagee!.path);

    });
  }

  void uploadImage(context) async {


    try {
   

    FirebaseStorage storage =
 FirebaseStorage.instanceFor(bucket: 'gs://rocheta-6a656.appspot.com');

     Reference ref = storage.ref().child(p.basename(_image!.path));
      UploadTask storageUploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await storageUploadTask;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(()  {
        
        _url = url;

       
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(""),
      ));
    }

  


  }
}