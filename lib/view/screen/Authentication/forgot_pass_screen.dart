import 'package:flutter/material.dart';
import 'package:food_ordering/core/services/auth_services.dart';
import 'package:food_ordering/utils/style.dart';
import 'package:food_ordering/view/shared/widget/text_field_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
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
                    "Forgot Password?",
                    style: TextStyle(
                      color: Color.fromRGBO(21, 34, 79, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "If you need help resetting your password, we\ncan help by sending you a link to reset it.",
                    style: TextStyle(color: Color.fromRGBO(150, 154, 168, 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: ReUsedTextFieldWidget(
                      validator: (p0) =>
                          p0!.isEmpty ? 'please fill this' : null,
                      labelText: "Email",
                      isObsecure: false,
                      textEditingController: _emailController),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(_emailController.text);
                        AuthServices().changePassword(
                            context, _emailController.text.trim());
                      } else {
                        print("noo");
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
      ),
    );
  }
}
