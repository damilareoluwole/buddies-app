import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/settings/app_theme.dart';

class Helper {
  Helper();

  BuildContext getContext() {
    return NavigationService.instance.getNavigationKey().currentState!.context;
  }

  String capitalizeFirstLetter(String s) => s[0].toUpperCase() + s.substring(1);

  void showSnackBar(String message,
      {int durationSeconds = 5, isError = false}) {
    Duration duration = Duration(seconds: durationSeconds);

    var snackBar = SnackBar(
      content: Text(
        message,
        // style: AppTheme.body.copyWith(color: AppTheme.kFixedWhite),
      ),/*backgroundColor:
          (isError) ? AppTheme.kErrorTextColor : AppTheme.kPrimaryColor, */
      duration: duration,
      action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () =>
              ScaffoldMessenger.of(getContext()).removeCurrentSnackBar()),
    );
    ScaffoldMessenger.of(getContext()).showSnackBar(snackBar);
  }

  void processCopy(String data, {String? message}) {
    Clipboard.setData(ClipboardData(text: data));

    var msg = message ?? "Copied to clipboard!";

    showSnackBar(msg);
  }

  popScreen(BuildContext context, {returnValue}) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, returnValue);
    }
  }

  double getWidth(int width) {
    return (width * MediaQuery.of(getContext()).size.width) / 390;
  }

  double getHeight(int height) {
    return (height * MediaQuery.of(getContext()).size.height) / 844;
  }

  showErrorSnackBar(message) {
    var context = NavigationService.instance.getContext();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.redColor,
      ),
    );
  }

  showSuccessfulSnackBar(message) {
    var context = NavigationService.instance.getContext();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
