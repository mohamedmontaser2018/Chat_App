import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.hintText, this.onChanged, this.ObsecureText = false});
  Function(String)? onChanged;
  String? hintText;
  bool? ObsecureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: ObsecureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Fields are Required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.amber,
        )),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
      ),
    );
  }
}
