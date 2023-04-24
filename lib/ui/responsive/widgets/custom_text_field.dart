
import 'package:flutter/material.dart';

Widget customTextField(hint, prefixIcon, keyboardType, controller, validator, {obscureText= false}){
  return TextFormField(
    keyboardType: keyboardType,
    obscureText: obscureText,
    controller: controller,
    validator: validator,
    decoration:  InputDecoration(
      hintText: hint,
      prefixIcon: Icon(prefixIcon)
    ),
  );
}