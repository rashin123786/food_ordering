
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ordering/view/screen/Authentication/success_screen.dart';

import '../../../utils/style.dart';
import '../../shared/widget/otp_widget.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.otp, required this.isLogin});
  final String otp;
  final bool isLogin;
  final firstcontroller = TextEditingController();
  final secondcontroller = TextEditingController();

  final thirdcontroller = TextEditingController();
  final forthcontroller = TextEditingController();

  final fifthcontroller = TextEditingController();
  final sixthcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Code Verification",
                  style: TextStyle(
                    color: Color.fromRGBO(21, 34, 79, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5),
                child: Text(
                  "Your Verification Code :\n$otp",
                  style: const TextStyle(
                    color: Color.fromRGBO(21, 34, 79, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    otpRow(controller: firstcontroller),
                    otpRow(controller: secondcontroller),
                    otpRow(controller: thirdcontroller),
                    otpRow(controller: forthcontroller),
                    otpRow(controller: fifthcontroller),
                    otpRow(controller: sixthcontroller)
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String otpText =
                        firstcontroller.text + secondcontroller.text + thirdcontroller.text + forthcontroller.text + fifthcontroller.text + sixthcontroller.text;
                    if (otp == otpText) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SuccessScreen(isLogin: isLogin),
                          ));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Enter Verification code correctly",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: backgroundColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 50),
                      backgroundColor: backgroundColor,
                      foregroundColor: Colors.white),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
