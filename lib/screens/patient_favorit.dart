// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screens/login_screen.dart';


class FavPatientScreen extends StatefulWidget { //FavPatientScreen
  const FavPatientScreen({ Key? key }) : super(key: key);

  @override
  _FavPatientScreenState createState() => _FavPatientScreenState();
}

class _FavPatientScreenState extends State<FavPatientScreen> {

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
     title: Text("Favorite"),
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




body: Column(

mainAxisAlignment: MainAxisAlignment.center,
children: const <Widget>[
  Center(
    child: Text("FAVOITE page", style: TextStyle(fontSize: 20),),
  )



],


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