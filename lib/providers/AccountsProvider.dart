import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/model/UserSignupResponse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

class AccountsProvider with ChangeNotifier {
  SigningUpState signingUpState = SigningUpState.NONE;

  Box<DopeUser> _accountHiveBox;

  AccountsProvider() {
    openHiveBox();
  }

  openHiveBox() {
    _accountHiveBox = Hive.box<DopeUser>("USER");
  }

  Future<UserCredential> googleUserCredd;

  doGogleAuth() async {
    var value = await signInWithGoogle();
    print("token ${value.credential.token}");

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
    saveUserExtras(resp.data.user,value.user.uid);
    setSignUpState(SigningUpState.DONE);
    notifyListeners();
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

  saveUserExtras(DopeUser dopeUser, String uid) {
    dopeUser.uid = uid;
    dopeUser.isLoggedIn = true;
    _accountHiveBox.put("USER", dopeUser);
  }

  logout()
  {
    _accountHiveBox.put("USER", DopeUser());
    FirebaseAuth.instance.signOut();

  }

  DopeUser getUserExtras() {
    return _accountHiveBox.get("USER");
  }

  Future<DopeUser> getUserFuture() async {
    return _accountHiveBox.get("USER");
  }
}

enum SigningUpState { NONE, LOADING, DONE }
