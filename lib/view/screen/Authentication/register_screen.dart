import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering/core/provider/loading_provider.dart';
import 'package:food_ordering/core/services/auth_services.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:food_ordering/view/screen/Authentication/login_screen.dart';

import 'package:provider/provider.dart';

import '../../shared/widget/text_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset('assets/images/logo.svg'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      'Register',
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
                    height: 10,
                  ),
                  // SizedBox(
                  //   width: 200,
                  //   height: 100,

                  // )
                  ReUsedTextFieldWidget(
                      validator: (p0) =>
                          p0!.isEmpty ? "please Enter Name" : null,
                      labelText: 'Name',
                      isObsecure: false,
                      textEditingController: _nameController),
                  ReUsedTextFieldWidget(
                      validator: (p1) =>
                          p1!.isEmpty ? "please Enter Email" : null,
                      labelText: 'Email id',
                      isObsecure: false,
                      textEditingController: _emailController),
                  ReUsedTextFieldWidget(
                      length: 10,
                      textInputType: TextInputType.number,
                      validator: (p1) =>
                          p1!.isEmpty ? "please Enter Number" : null,
                      labelText: 'Phone number',
                      isObsecure: false,
                      textEditingController: _numberController),
                  ReUsedTextFieldWidget(
                      validator: (p2) =>
                          p2!.isEmpty ? "please Enter Password" : null,
                      labelText: 'Password',
                      isObsecure: true,
                      textEditingController: _passwordController),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<LoadingProvider>(
                    builder: (context, value, child) => ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          value.setLoading(true);
                          await AuthServices().registerUser(
                              context,
                              _nameController.text,
                              _emailController.text,
                              _numberController.text,
                              _passwordController.text);
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
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(isLogin: true),
                        )),
                    child: RichText(
                      text: TextSpan(
                          text: "Do you have an account ? ",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: 'Login',
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
