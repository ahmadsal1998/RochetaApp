// ignore_for_file: unnecessary_this, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user_details.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginController with ChangeNotifier {
  // object
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;

  // fucntion for google login
  googleLogin() async {
    this.googleSignInAccount = await _googleSignIn.signIn();
    // inserting values to our user details model

    // ignore: unnecessary_new
    this.userDetails = new UserDetails(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,
    );

    // call
    notifyListeners();
  }

  // function for facebook login
  facebooklogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    // check the status of our login
    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );

      // ignore: unnecessary_new
      this.userDetails = new UserDetails(
        displayName: requestData["name"],
        email: requestData["email"],
        photoURL: requestData["picture"]["data"]["url"] ?? " ",
      );
      notifyListeners();
    }
  }

  // logout

  logout() async {
    this.googleSignInAccount = await _googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    userDetails = null;
    notifyListeners();
  }
}
