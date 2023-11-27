import 'dart:convert';

import 'package:food_ordering/core/model/AuthModel/login_model.dart';
import 'package:food_ordering/core/model/home_model.dart';
import 'package:food_ordering/utils/api_constant.dart';
import 'package:food_ordering/utils/constants.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Order>> getHomeOrder() async {
    final header = {
      'Authorization': 'Bearer $userId',
    };
    final response =
        await http.get(Uri.parse(ApiConstant.homeUrl), headers: header);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final orderList = jsonResponse['data']['orders'] as List<dynamic>;

      userDetails = UserModel.fromJson(jsonResponse['data']['user_details']);
      final orders =
          orderList.map((orderJson) => Order.fromJson(orderJson)).toList();

      return orders;
    } else if (response.statusCode == 302) {
      throw Exception('Logged in on another device!');
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<List<Order>> getSearch(String query) async {
    final header = {
      'Authorization': 'Bearer $userId',
    };
    final response =
        await http.get(Uri.parse(ApiConstant.homeUrl), headers: header);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final orderList = jsonResponse['data']['orders'] as List<dynamic>;
      userDetails = UserModel.fromJson(jsonResponse['data']['user_details']);
      final orders =
          orderList.map((orderJson) => Order.fromJson(orderJson)).toList();

      if (query.isNotEmpty) {
        return orders
            .where((element) => element.items!.product!.name!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } else {
        return orders;
      }
    } else if (response.statusCode == 302) {
      throw Exception('Logged in on another device!');
    } else {
      print(response.statusCode);
      throw Exception('Failed to load orders${response.statusCode}');
    }
  }
}
