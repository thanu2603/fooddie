import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle headlineTextFieldStyle() {
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle lightlineTextFieldStyle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w100,
      color: Colors.black54,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle semiBoldTextFieldStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
      fontFamily: 'Poppins',
    );
  }
}
