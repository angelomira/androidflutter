import 'package:flutter/material.dart';
import '../data/pallets.dart';

class CustomMultilineLabel {
  static create(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Row(children: [
            Text(
              label,
              style: TextStyle(
                color: CustomDarkTheme.baseColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Text(
                value.isEmpty ? 'No data provided.' : value,
                style: TextStyle(
                  color: CustomDarkTheme.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}