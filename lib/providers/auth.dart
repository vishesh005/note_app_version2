import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:note_app/base/app_config.dart';
import 'package:note_app/exceptions/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TOKEN="_token__";
const USER_ID ="_userId__";
const EXPIRY_DATE="_expiryDate__";

class Auth extends ChangeNotifier{

  String token;
  String userId;
  DateTime expiryDate;


  bool get isAuth{
    return token != null && token.isNotEmpty;
  }

  Future<void> autoLogin() async{
    final pref = await SharedPreferences.getInstance();
    final isUserAuthenticated = pref.containsKey(USER_ID);
    if(isUserAuthenticated){
       userId = pref.getString(USER_ID);
       token = pref.get(TOKEN);
       expiryDate = DateTime.parse(EXPIRY_DATE);
    }
    return;
  }

  Future<void> loginUser(String email,String password) async {
    try {
      final response = await http.post(AppConfig.signInUrl, body: {
        "email": email,
        "password": password,
        "returnSecureToken": "true"
      });
      final loginResponse = jsonDecode(response.body);
      if (loginResponse["error"] != null) {
        throw HttpException(loginResponse["error"]["message"]);
      }
      token = loginResponse["idToken"];
      userId = loginResponse["localId"];
      expiryDate = DateTime.now().add(
          Duration(seconds: int.parse(loginResponse["expiresIn"])));
      final ref = await SharedPreferences.getInstance();
      ref.setString(TOKEN, token);
      ref.setString(USER_ID, userId);
      ref.setString(EXPIRY_DATE, expiryDate.toIso8601String());
      notifyListeners();
      print(loginResponse["expiresIn"]);
      autoLogOut();
    }catch(e){
      throw e;
    }
  }

  void autoLogOut() {
    final currentTime = DateTime.now();
    if (expiryDate.isBefore(currentTime) || expiryDate.isAtSameMomentAs(currentTime)) {
       logoutUser();
    } else {
      Timer(Duration(seconds:expiryDate.difference(currentTime).inSeconds), logoutUser);
    }
  }

  Future<void> registerUser(String email, String password) async {
    try {
      final response = await http.post(AppConfig.signUpUrl, body: {
        "email": email,
        "password": password,
        "returnSecureToken": "true"
      });
      if(response.statusCode > 400){
        throw HttpException("Unable to register");
      }
    }catch(error){
      throw error;
    }
  }

  Future<void> logoutUser()async {
   final pref =  await SharedPreferences.getInstance();
   pref.clear();
    userId = "";
    expiryDate = null;
    token = "";
    notifyListeners();
  }

  Future<void> loadUserDetails()async {
    final pref =  await SharedPreferences.getInstance();
    token = pref.getString(TOKEN);
    userId= pref.getString(USER_ID);
    final expiryDateString = pref.getString(EXPIRY_DATE);
    if(expiryDateString.isNotEmpty){
      expiryDate = DateTime.parse(expiryDateString);
    }
    else{
      logoutUser();
    }
  }


}