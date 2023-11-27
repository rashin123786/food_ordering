import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ordering/core/services/home_services.dart';
import 'package:food_ordering/utils/api_constant.dart';

import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../utils/style.dart';

class ResponseServices {
  Future getResponseOrder(
      {required String orderId,
      required String orderStatus,
      required String id}) async {
    final header = {
      'Authorization': 'Bearer $userId',
      "Content-Type": "application/json",
    };

    final body = jsonEncode(
        {"order_id": orderId, "order_status": orderStatus, "user_id": id});
    final response = await http.post(Uri.parse(ApiConstant.responseOrderUrl),
        body: body, headers: header);

    if (response.statusCode == 302) {
      final location = response.headers['location']; // Get the redirect URL
    } else if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}
