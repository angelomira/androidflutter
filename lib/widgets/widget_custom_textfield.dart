import 'package:flutter/material.dart';

import '../data/pallets.dart';

class CustomTextField {
  static create(TextEditingController controller, String hintText, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: CustomDarkTheme.baseColor,
            width: 1.5,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: CustomDarkTheme.backgroundColor),
        labelText: labelText,
        labelStyle: TextStyle(color: CustomDarkTheme.accentColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: CustomDarkTheme.baseColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: CustomDarkTheme.accentColor,
            width: 1.5,
          ),
        ),
      ),
      cursorColor: CustomDarkTheme.accentColor,
      maxLines: 1,
    );
  }
}