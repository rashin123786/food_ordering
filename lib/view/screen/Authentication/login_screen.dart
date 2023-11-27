import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering/core/provider/loading_provider.dart';
import 'package:food_ordering/core/services/auth_services.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:food_ordering/view/screen/Authentication/forgot_pass_screen.dart';
import 'package:food_ordering/view/screen/Authentication/register_screen.dart';
import 'package:provider/provider.dart';

import '../../shared/widget/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.isLogin});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset('assets/images/logo.svg'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Text(
                    "Ready for explore the world of food and\nyou can order favourite food",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color.fromRGBO(150, 154, 168, 1)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ReUsedTextFieldWidget(
                      validator: (p1) =>
                          p1!.isEmpty ? "please Enter Email" : null,
                      labelText: 'Email',
                      isObsecure: false,
                      textEditingController: _emailController),
                  ReUsedTextFieldWidget(
                      validator: (p2) =>
                          p2!.isEmpty ? "please Enter Password" : null,
                      labelText: 'Password',
                      isObsecure: true,
                      textEditingController: _passwordController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            )),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: backgroundColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<LoadingProvider>(
                    builder: (context, value, child) => ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          value.setLoading(true);
                          await AuthServices().loginUser(context,
                              _emailController.text, _passwordController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 50),
                          backgroundColor: backgroundColor,
                          foregroundColor: Colors.white),
                      child: value.isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Continue'),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        )),
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account ? ",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: 'Sign up',
                                style: TextStyle(color: backgroundColor))
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
