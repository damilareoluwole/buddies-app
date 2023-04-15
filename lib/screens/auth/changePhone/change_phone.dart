import 'package:flutter/material.dart';
import 'package:buddies/screens/auth/changePhone/change_phone_confirm_password.dart';
import 'package:buddies/screens/auth/changePhone/change_send_phone_otp.dart';
import 'package:buddies/screens/auth/changePhone/change_verify_phone_otp.dart';
import 'package:buddies/services/helper.dart';

void showPhoneDialog() {
  showDialog<void>(
    context: Helper().getContext(),
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text("Enter your password to continue",
            textAlign: TextAlign.center),
        content: ConfimPhonePassword(),
      );
    },
  );
}

void enterPhoneDialog() {
  showDialog<void>(
    context: Helper().getContext(),
    builder: (BuildContext context) {
      return const AlertDialog(
        title:
            Text("Enter your phone to continue", textAlign: TextAlign.center),
        content: ChangeSendPhoneOtp(),
      );
    },
  );
}

void enterPhoneOtp({required String phone}) {
  showDialog<void>(
    context: Helper().getContext(),
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Enter OTP to continue", textAlign: TextAlign.center),
        content: ChangeEnterPhoneOtp(phone: phone),
      );
    },
  );
}
