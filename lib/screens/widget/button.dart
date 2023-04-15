import 'package:flutter/material.dart';
import 'package:buddies/settings/app_theme.dart';

Widget buttonWidget({
  required String text,
  required Function() onPressed,
  Color? bgColor,
  width = double.infinity,
  height = 44.0,
}) {
  return Container(
    color: bgColor ?? AppTheme.redColor,
    width: width,
    height: height,
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTheme.button,
      ),
    ),
  );
}
