import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Snakbars {
  static Future<void> simpleSnackBar(BuildContext context, String msg) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Future<void> flushBar(
      BuildContext context, String msg, Color bgColor) async {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        backgroundColor: bgColor,
        borderRadius: BorderRadius.circular(30),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        message: msg,
      )..show(context),
    );
  }
}
