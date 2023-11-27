import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../utils/api_constant.dart';
import '../../utils/constants.dart';
import '../model/profile_model.dart';

class LoadingProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  int _orderStatus = 0;

  int get orderStatus => _orderStatus;

  void setOrderStatus(int newOrderStatus) {
    _orderStatus = newOrderStatus;
    notifyListeners();
  }

  Future<ProfileModel> getProfileData() async {
    final header = {
      'Authorization': 'Bearer $userId',
    };
    final response =
        await http.get(Uri.parse(ApiConstant.getProfile), headers: header);
    print(response.statusCode);
    if (response.statusCode == 200) {
      notifyListeners();
      final jsonresponse = jsonDecode(response.body);
      final result = jsonresponse['data'];
      final data = await ProfileModel.fromJson(result);
      notifyListeners();
      return data;
    } else {
      throw Exception(Text("Failed To Load"));
    }
  }
}
