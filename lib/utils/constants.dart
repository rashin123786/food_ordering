import 'package:another_stepper/dto/stepper_data.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/core/model/AuthModel/login_model.dart';

import '../core/model/AuthModel/register_model.dart';

List<StepperData> stepperData = [
  StepperData(
      title: StepperText(
        "Cisaat Street 1322",
        textStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      subtitle: StepperText("Food arrival at 35min"),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(190, 237, 190, 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Icon(Icons.timer_outlined, color: Colors.green),
      )),
  StepperData(
      title: StepperText(
        "Apartment Bridge",
        textStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      subtitle: StepperText("JI. Pondok Leugsir Street"),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(190, 237, 190, 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Icon(Icons.location_on_outlined, color: Colors.green),
      )),
];
RegisterModel? userData;
String? userId;
UserModel? userDetails;
List<String> vegetableName = [
  "Tomato",
  "Potato",
  "Apple",
  "Orange",
  "Carrot",
  "Pumpkin",
  "onion",
  "pea",
  "Grapes",
];
const String GOOGLE_MAPS_API_KEY = "AIzaSyApJRbaVZNuthc2Mi72xifDbdk8b-3WI9Q";
