import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FirebaseProvider with ChangeNotifier
{
  FirebaseAnalytics _firebaseAnalytics;

  FirebaseAnalytics get firebaseAnalytics => _firebaseAnalytics;

  FirebaseProvider()
  {
    Firebase.initializeApp();
    _firebaseAnalytics = FirebaseAnalytics();
  }
}