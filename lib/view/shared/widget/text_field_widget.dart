import 'package:flutter/material.dart';

class ReUsedTextFieldWidget extends StatelessWidget {
  const ReUsedTextFieldWidget({
    super.key,
    required this.labelText,
    required this.isObsecure,
    required this.textEditingController,
    this.validator,
    this.textInputType,
    this.length,
  });
  final String labelText;
  final int? length;
  final TextInputType? textInputType;
  final bool isObsecure;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: TextFormField(
          maxLength: length,
          keyboardType: textInputType,
          expands: false,
          validator: validator,
          controller: textEditingController,
          obscureText: isObsecure,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
          ),
        ),
      ),
    );
  }
}
