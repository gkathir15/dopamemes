

import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dopamemes/model/UserExtrasData.dart';
import 'package:dopamemes/model/UserLoginData.dart';
import 'package:dopamemes/providers/Conts.dart';
import 'package:dopamemes/model/Db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountsProvider with ChangeNotifier {
  Future<bool> isLoggedIn;
  bool isEmailValidated = false;
  bool isPasswrordValidated = false;
  bool isUseNameValidated = false;
 Future<UserLoginData> isLoggedResponse;
 bool isLoggedInChecked=false;


 //var userCred =  await signInWithGoogle();







  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }




  



  // saveUsrToDb(UserLoginData loggedResp)
  // async {
  //  // var db = new Database(AppWriteClientProvider().client);
  //   var age = 18;
  //   var time = DateTime.now().millisecondsSinceEpoch;
  //
  // return await
  // db.createDocument(collectionId: UsersDb, data:{"{userID:${loggedResp.id},email:${loggedResp.email},dispName:${loggedResp.name},profileImage: ,age:$age,updatedAt:$time}"
  //
  //
  //   } , read: ["*"], write: ["*"]);
  //
  //
  // }

  showEmailValidator()
  {
    isEmailValidated = true;
    notifyListeners();
  }
  showPasswordValidator()
  {
    isPasswrordValidated = true;
    notifyListeners();
  }
  showUserNameValidator()
  {
    isUseNameValidated = true;
    notifyListeners();
  }



  Future<UserLoginData> returnUserData(dynamic response) async{
    return UserLoginData.fromJson(jsonDecode(response.toString()));
  }

  saveUserExtras(String userExtras)
  async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("USER_EXTRAS", userExtras);
  }
  getUserExtras(String userExtras)
  async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.getString("USER_EXTRAS");
  }
}
