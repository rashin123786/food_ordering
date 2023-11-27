import 'package:flutter/material.dart';
import 'package:food_ordering/core/provider/loading_provider.dart';
import 'package:food_ordering/core/services/profile_services.dart';
import 'package:food_ordering/view/shared/widget/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../../../utils/style.dart';

class AlertProfileUpdate extends StatelessWidget {
  AlertProfileUpdate({super.key, required this.name, required this.number});
  final String name;
  final String number;

  @override
  Widget build(BuildContext context) {
    final loadProvider = Provider.of<LoadingProvider>(context, listen: false);
    final nameController = TextEditingController(text: name);
    final phoneController = TextEditingController(text: number);
    return SizedBox(
      height: 300,
      child: AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: phoneController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Phone"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ProfileServices().updateProfile(context,
                      name: nameController.text, number: phoneController.text);
                },
                child: Text("Update"),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: backgroundColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
