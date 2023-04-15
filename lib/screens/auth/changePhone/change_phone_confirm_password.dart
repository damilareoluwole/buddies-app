// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:buddies/screens/auth/changePhone/change_phone.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/screens/widget/text_field.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/validator.dart';
import 'package:buddies/settings/app_theme.dart';

class ConfimPhonePassword extends StatefulWidget {
  const ConfimPhonePassword({super.key});

  @override
  State<ConfimPhonePassword> createState() => _ConfimPhonePasswordState();
}

class _ConfimPhonePasswordState extends State<ConfimPhonePassword> {
  final _confirmPhoneFormKey = GlobalKey<FormState>();
  final passwordPhoneController = TextEditingController();
  var processing = false;

  @override
  void initState() {
    requestErrors = null;
    super.initState();
  }

  @override
  void dispose() {
    passwordPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              child: Text(
                textAlign: TextAlign.center,
                "Please enter your buddies password to continue.",
                style:
                    AppTheme.hintText.copyWith(color: AppTheme.darkGreyColor),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Helper().getWidth(24),
              vertical: Helper().getHeight(24),
            ),
            child: Form(
              key: _confirmPhoneFormKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    isPassword: true,
                    hintText: "Password",
                    validator: (value) {
                      return Validator().validatePassword(value);
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordPhoneController,
                  ),
                  checkRequestErrors('password'),
                  SizedBox(
                    height: Helper().getHeight(20),
                  ),
                  (processing)
                      ? const CircularProgressIndicator()
                      : buttonWidget(
                          text: "Confirm Password",
                          onPressed: () {
                            _confirmPhonePassword();
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _confirmPhonePassword() async {
    setState(() {
      requestErrors = null;
    });

    if (_confirmPhoneFormKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var passwordData = {
        "password": passwordPhoneController.text,
      };

      try {
        var response = await ApiClient()
            .httpPostRequest(ApiEndpoints.confirmPassword, passwordData);

        setState(() {
          processing = false;
        });

        if (response["status"] == true &&
            response["data"] != null &&
            response["data"]["user"] != null) {
          Navigator.pop(context);
          enterPhoneDialog();
        } else {
          Helper().showErrorSnackBar(response["message"]);
        }
      } catch (e) {
        setState(() {
          processing = false;
        });
      }
    }
  }
}
