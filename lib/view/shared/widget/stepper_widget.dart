import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget({
    super.key,
    required this.firstTile,
    required this.secondTitle,
    required this.firstSubtitle,
    required this.secondSubtitle,
  });
  final String firstTile;
  final String secondTitle;
  final String firstSubtitle;
  final String secondSubtitle;

  @override
  Widget build(BuildContext context) {
    return AnotherStepper(
      stepperList: [
        StepperData(
            title: StepperText(
              firstTile,
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
            subtitle: StepperText(firstSubtitle),
            iconWidget: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(190, 237, 190, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Icon(Icons.timer_outlined, color: Colors.green),
            )),
        StepperData(
            title: StepperText(
              secondTitle,
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
            subtitle: StepperText(secondSubtitle),
            iconWidget: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(190, 237, 190, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child:
                  const Icon(Icons.location_on_outlined, color: Colors.green),
            )),
      ],
      stepperDirection: Axis.vertical,
      iconWidth: 40,
      iconHeight: 40,
    );
  }
}
