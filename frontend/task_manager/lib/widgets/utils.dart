import 'package:flutter/material.dart';

ScaffoldMessengerState showSnackBar(
    {required String text, required Color backgroundColor,required BuildContext context}) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: backgroundColor,
      ),
    );
}