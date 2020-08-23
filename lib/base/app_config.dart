import 'package:flutter/material.dart';

class AppConfig {

  static const primarySwatch = Colors.brown;
  static const accentColor = Colors.orange;
  static const appName ="Note App V2";
  static const firebaseAppName = "practice-app-cad8a";
  static const baseFirebaseDbUrl = "https://$firebaseAppName.firebaseio.com/notes.json";
  static const baseFirebaseAuthUrl ="https://identitytoolkit.googleapis.com/v1/accounts:";
  static const authKey = "// Your Key Here //";
  static const signUpUrl ="${baseFirebaseAuthUrl}signUp?key=$authKey";
  static const signInUrl= "${baseFirebaseAuthUrl}signInWithPassword?key=$authKey";
  static String dbGetUrl(String authToken,String userId) => baseFirebaseDbUrl + "auth=$authToken&orderBy=createdBy&equalTo=$userId";
  static String dbPutDeleteUrl(String authToken,String userId) => baseFirebaseDbUrl + "/$userId/auth=$authToken";
  static String dbPostUrl(String authToken) => baseFirebaseDbUrl +"auth=";
}
