import 'package:flutter/material.dart';
import 'package:buddies/screens/auth/changeEmail/change_email_confirm_password.dart';
import 'package:buddies/screens/auth/changeEmail/change_send_email_otp.dart';
import 'package:buddies/screens/auth/changeEmail/change_verify_email_otp.dart';
import 'package:buddies/services/helper.dart';

void showEmailDialog() {
  showDialog<void>(
    context: Helper().getContext(),
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text("Enter your password to continue",
            textAlign: TextAlign.center),
        content: ConfimPassword(),
      );
    },
  );
}

void enterEmailDialog() {
  showDialog<void>(
    context: Helper().getContext(),
    builder: (BuildContext context) {
      return const AlertDialog(
        title:
            Text("Enter your Email to continue", textAlign: TextAlign.center),
        content: ChangeSendEmailOtp(),
      );
    },
  );
}

void enterOtp({required String email}) {
  showDialog<void>(
    context: Helper().getContext(),
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Enter OTP to continue", textAlign: TextAlign.center),
        content: ChangeEnterEmailOtp(email: email),
      );
    },
  );
}
