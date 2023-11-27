import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:food_ordering/view/screen/Home/home_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.isLogin});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Congratulations !",
                  style: TextStyle(
                    color: Color.fromRGBO(21, 34, 79, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: SvgPicture.asset('assets/images/success.svg'),
              ),
              const Spacer(),
              Text(
                isLogin == true
                    ? "Your account has been\nsuccessfully login"
                    : "Your account has been\nsuccessfully created",
                style: const TextStyle(
                  color: Color.fromRGBO(21, 34, 79, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: backgroundColor,
                    foregroundColor: Colors.white),
                child: const Text('Back to home'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
