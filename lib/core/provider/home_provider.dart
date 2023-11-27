import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ordering/core/model/home_model.dart';
import 'package:food_ordering/core/services/home_services.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_constant.dart';
import '../../utils/constants.dart';
import '../../utils/style.dart';
import '../model/AuthModel/login_model.dart';

class HomeProvider with ChangeNotifier {
  Future<List<Order>>? orderSearch;
  bool istap = false;
  onButtonChanged(value) {
    orderSearch = HomeServices().getSearch(value);
    notifyListeners();
  }

  updateStausOrder(
      {required String orderId,
      required String orderStatus,
      required String id}) async {
    final header = {
      'Authorization': 'Bearer $userId',
      "Content-Type": "application/json",
    };
    final body = jsonEncode(
        {"order_id": orderId, "order_status": orderStatus, "user_id": id});
    final response = await http.post(Uri.parse(ApiConstant.updateStatus),
        headers: header, body: body);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);

      ;
      notifyListeners();
      print(result["data"]["delivery_status"]);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong,Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: backgroundColor,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  updatePaymentStatus(
      {required String orderId,
      required String paymentStatus,
      required String paymentMethod}) async {
    final header = {
      'Authorization': 'Bearer $userId',
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "order_id": orderId,
      "payment_status": paymentStatus,
      "payment_method": paymentMethod,
    });
    final response = await http.post(Uri.parse(ApiConstant.updatePaymentStatus),
        headers: header, body: body);
    if (response.statusCode == 200) {
      notifyListeners();

      final result = jsonDecode(response.body);
      notifyListeners();
    }
  }
}
