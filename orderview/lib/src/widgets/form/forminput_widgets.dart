import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Icon? customIcon;
  final TextEditingController customController;
  final String? Function(String?)? validadorCustom;
  final bool isRequired;
  const FormInput({
    super.key,
    required this.labelText,
    this.customIcon,
    required this.customController,
    required this.validadorCustom,
    this.isRequired = false,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              labelText,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            if (isRequired)
              Text(
                '*',
                style: TextStyle(color: Colors.redAccent, fontSize: 20),
              ),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: customController,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 17),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white70, width: 1.5)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          style: TextStyle(color: Colors.white),
          validator: validadorCustom,
        ),
      ],
    );
  }
}
