import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  void showToast(
      {Toast length = Toast.LENGTH_SHORT,
      ToastGravity gravity = ToastGravity.BOTTOM,
      required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: length,
        gravity: gravity,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xFF47e4c1),
        webBgColor: "linear-gradient(to right, #47e4c1, #47e4c1)",
        webPosition: "center",
        textColor: Colors.black,
        fontSize: 15);
  }
}
