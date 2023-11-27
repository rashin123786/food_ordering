import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ordering/core/model/profile_model.dart';
import 'package:food_ordering/core/provider/loading_provider.dart';
import 'package:food_ordering/utils/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../utils/style.dart';

class ProfileServices {
  void updateProfile(context,
      {required String name, required String number}) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final header = {
      'Authorization': 'Bearer $userId',
    };
    final body = {"name": name, "avatar": "", "phone": number};

    final response = await http.post(
        Uri.parse("https://freshapplefarm.in/api/driver-profile/update"),
        headers: header,
        body: body);
    print("response:${response.statusCode}");
    if (response.statusCode == 200) {
      loadingProvider.getProfileData();
      Navigator.pop(context);
    }
  }

  void changePassword(context, String password) async {
    final header = {
      'Authorization': 'Bearer $userId',
    };
    final body = {"password": password};
    final response = await http.post(Uri.parse(ApiConstant.changePassword),
        headers: header, body: body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Succesfully changed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: backgroundColor,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: backgroundColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
