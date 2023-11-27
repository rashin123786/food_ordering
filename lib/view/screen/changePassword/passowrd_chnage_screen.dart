import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_ordering/core/services/profile_services.dart';
import 'package:food_ordering/view/shared/widget/text_field_widget.dart';

import '../../../utils/style.dart';

class ChangePasword extends StatelessWidget {
  ChangePasword({super.key});
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change password"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              ReUsedTextFieldWidget(
                  validator: (p1) => p1!.isEmpty ? 'please fill this ' : null,
                  labelText: "change password",
                  isObsecure: true,
                  textEditingController: passwordController),
              SizedBox(
                height: 10,
              ),
              ReUsedTextFieldWidget(
                  validator: (p0) => p0!.isEmpty ? 'please fill this ' : null,
                  labelText: "Confirm  password",
                  isObsecure: false,
                  textEditingController: confirmPasswordController),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (confirmPasswordController.text ==
                        passwordController.text) {
                      ProfileServices().changePassword(
                          context, passwordController.text.trim());
                    } else {
                      Fluttertoast.showToast(
                          msg: "password and confirm password does not match",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: backgroundColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }
                },
                child: Text("Confirm"),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: backgroundColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
