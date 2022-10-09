import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthDefault());

 final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  // login method
  Future login(String email, String password) async {
    emit(const AuthLoginLoading());
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      // login success state
      if (user != null) {
        emit(AuthLoginSuccess(user: user));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthLoginError(error: e.message!));
    }
  }

  // signup method
  Future signUp(String name, String password, String email) async {
    emit(const AuthSignUpLoading());
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      // if the user is not null
      if (user != null) {
        user.updateDisplayName(name);
        emit(const AuthSignUpSuccess());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthSignUpError(e.message));
    }
  }

  // forgot password method
  Future forgotPassword(String email) async {
    emit(const AuthForgotPasswordLoading());
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      emit(const AuthForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthForgotPasswordError(e.message));
    }
  }

 // auth logout
  Future logout() async {
    await firebaseAuth.signOut();
    emit(const AuthLogout());
  }






















}
