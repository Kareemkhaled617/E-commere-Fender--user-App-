import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  Map userData = {};
  bool signIp=false;

  Future register(
      {required String email, password, fName, lName, phone}) async {
    await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/user/register.php'),
        body: {
          'email': email,
          "username": email,
          "password": password,
          'phone': phone,
          'l_name': lName,
          'f_name': fName
        }).then((value) async {
      final map = json.decode(value.body);
      Response rr = await post(
          Uri.parse('https://ibtikarsoft.net/finder/api/user/otp.php'),
          body: {'token': map['token'], 'otp': map['otp']});

    });
  }

  Future login({required String email, password}) async {
    Response res = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/user/login.php'),
        body: {
          'username': email,
          "password": password,
        });
    var data = json.decode(res.body);
    return data;
  }

  saveUserData(String image, String email, String token, String f_name,
      String l_name) async {
    var prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> dataUser = {
      "token": token,
      "f_name": f_name,
      "l_name": l_name,
      "username": email,
      "image": image
    };
    String encodedMap = json.encode(dataUser);
    prefs.setString('userData', encodedMap);
  }

  saveSignIn(bool signIn) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('signIn', signIn);
  }

  Future getSignIn() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.getBool('signIn');
    signIp=prefs.getBool('signIn') ?? false;
    notifyListeners();
  }

  Future getDataUser() async {
    var prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString('userData') ?? "";
    userData = json.decode(encodedMap);
    print(userData);
    print('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
    return userData;
  }

  Future<void> clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('userData');
  }
}
