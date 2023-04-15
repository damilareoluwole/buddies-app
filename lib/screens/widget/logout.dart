// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:buddies/screens/auth/logout.dart';
import 'package:buddies/settings/app_theme.dart';

showModal(context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: false,
    shape: AppTheme.bottomSheetStyle,
    context: context,
    builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LogoutScreen(),
      );
    },
  );
}
