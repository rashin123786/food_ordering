import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class otpRow extends StatelessWidget {
  const otpRow({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 50,
        width: 45,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            FocusScope.of(context).nextFocus();
          },
          style: Theme.of(context).textTheme.titleLarge,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.zero),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ),
    );
  }
}
