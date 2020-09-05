import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/model/UserSignupResponse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountsProvider with ChangeNotifier {
  // bool isEmailValidated = false;
  // bool isPasswrordValidated = false;
  // bool isUseNameValidated = false;
  Future<DopeUser> dopeuserResponse;
  //bool isLoggedInChecked=false;
  SigningUpState signingUpState = SigningUpState.NONE;

  Future<UserCredential> googleUserCredd;

  Future<DopeUser> SignUporSignIN() async {
   var value = await signInWithGoogle();

   print(value.additionalUserInfo.toString());
   print(value.credential.toString());
   print(value.user.toString());

   Response response;
   if (value.additionalUserInfo.isNewUser) {
     var data = UserDataRequest(
         name: value.user.displayName,
         imageUrl: value.user.photoURL,
         email: value.user.email,
         age: 0,
         uid: value.user.uid)
         .toJson();
     response = await Dio().post(Conts.baseUrl + "api/v1/users", data: data);
   } else {
     response = await Dio()
         .get(Conts.baseUrl + "api/v1/users/email/${value.user.email}");
   }
   print(response.toString());
   var resp = UserSignupResponse.fromJson(json.decode(response.toString()));

   print(resp.data.user.toJson().toString());
   saveUserExtras(resp.data.user.toJson().toString());
   // setSignUpState(SigningUpState.DONE);
   return resp.data.user;
  }

  void doGogleAuth() {
    dopeuserResponse = SignUporSignIN();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    setSignUpState(SigningUpState.LOADING);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  SigningUpState getLoadState() {
    return signingUpState;
  }

  setSignUpState(SigningUpState _signingUpState) {
    signingUpState = _signingUpState;
    notifyListeners();
  }


  saveUserExtras(String userExtras) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("USER_EXTRAS", userExtras);
  }

  Future<DopeUser> getUserExtras() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return DopeUser.fromJson(json.decode(_prefs.getString("USER_EXTRAS")));
  }

  Future<DopeUser> loggedResponse() {
    dopeuserResponse = getUserExtras();
  }
}

enum SigningUpState { NONE, LOADING, DONE }
