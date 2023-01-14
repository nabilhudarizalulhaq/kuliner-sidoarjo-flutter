import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastMessage(
    BuildContext context,
    String message
    ) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.pink,
      textColor: Colors.white,
      fontSize: 16.0
  );
}