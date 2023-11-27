import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:food_ordering/view/screen/Authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';
import '../Home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      userId = value.getString('id');
    });
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => userId == null
                ? LoginScreen(
                    isLogin: true,
                  )
                : const HomeScreen(),
          ));
    });
    super.initState();
  }

  navigateToHome() async {
    SharedPreferences.getInstance().then((value) {
      userId = value.getString('id');
    });
    await Future.delayed(const Duration(milliseconds: 1500), () async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => userId == null
                ? LoginScreen(isLogin: true)
                : const HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: Color(0xFFFB7D26),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/applelogo.png',
            ),
          ),
          const Positioned(
            right: -25,
            top: -20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color.fromARGB(30, 196, 196, 196),
            ),
          )
        ],
      ),
    );
  }
}
