// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:food_ordering/view/screen/Home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/core/provider/loading_provider.dart';
import 'package:food_ordering/utils/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../model/AuthModel/register_model.dart';

class AuthServices {
  //====Register User=========>

  Future<String> registerUser(context, String name, String email, String number,
      String password) async {
    final loadProvider = Provider.of<LoadingProvider>(context, listen: false);
    final headers = {
      "Content-type": "application/json",
    };
    print("$name $email $number $password");

    final body = jsonEncode(
        {"name": name, "email": email, "phone": number, "password": password});
    final response = await http.post(Uri.parse(ApiConstant.registerUrl),
        headers: headers, body: body);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      loadProvider.setLoading(false);
      final responseData = jsonDecode(response.body);
      final error = responseData['message'];
      if (responseData['message'] == "Successfully logged in") {
        userData = RegisterModel.fromJson(responseData);
        userId = userData!.accessToken;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', userId!);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        return userData!.user.phone!;
      } else {
        Fluttertoast.showToast(
            msg: "$error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: backgroundColor,
            textColor: Colors.white,
            fontSize: 16.0);
        throw Exception('$error');
      }
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    final loadProvider = Provider.of<LoadingProvider>(context, listen: false);

    final headers = {
      "Content-type": "application/json",
    };
    final body = jsonEncode({"email": email, "password": password});
    final response = await http.post(Uri.parse(ApiConstant.loginUrl),
        body: body, headers: headers);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['result'] == true) {
        userId = responseData['access_token'];

        print("iddddddddddddddddddddd:$userId");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', userId!);

        loadProvider.setLoading(false);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        loadProvider.setLoading(false);
        Fluttertoast.showToast(
            msg: "Email and password Does'nt Match",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: backgroundColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      loadProvider.setLoading(false);
      Fluttertoast.showToast(
          msg: "Email and password Does'nt Match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: backgroundColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void changePassword(context, String email) async {
    final headers = {
      "Content-type": "application/json",
    };
    final body = jsonEncode({
      "email": email,
    });
    final response = await http.post(Uri.parse(ApiConstant.forgotPasswordUrl),
        headers: headers, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String error = responseData["message"];
      if (responseData['message'] ==
          "We have emailed your password reset link!") {
        Fluttertoast.showToast(
            msg: "We have emailed your password reset link!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: backgroundColor,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: "$error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: backgroundColor,
            textColor: Colors.white,
            fontSize: 16.0);
        throw Exception('$error');
      }
    }
  }
}
