import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../provider/loading_provider.dart';

class GoogleMapServices {
  Future<Position> getCurrentLocation(context) async {
    final loadProvider = Provider.of<LoadingProvider>(context, listen: false);
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print(serviceEnabled);
    if (!serviceEnabled) {
      Fluttertoast.showToast(
        msg: "Please Enable Loaction",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      loadProvider.setLoading(false);

      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        loadProvider.setLoading(false);
        throw Exception('Location permission is denied');
      }
      loadProvider.setLoading(false);
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
        msg:
            "Location permission is permanently denied, we cannot request permission\nGo App setting enable location",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      loadProvider.setLoading(false);

      throw Exception('Location permission is permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
