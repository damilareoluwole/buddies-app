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

class ChangeSendPhoneOtp extends StatefulWidget {
  const ChangeSendPhoneOtp({super.key});

  @override
  State<ChangeSendPhoneOtp> createState() => _ChangeSendPhoneOtpState();
}

class _ChangeSendPhoneOtpState extends State<ChangeSendPhoneOtp> {
  final _sendPhoneOtpFormKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  var processing = false;

  @override
  void initState() {
    requestErrors = null;
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
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
                "Please enter your new phone number",
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
              key: _sendPhoneOtpFormKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    isPassword: true,
                    hintText: "Phone",
                    validator: (value) {
                      return Validator().validatePhone(value);
                    },
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                  ),
                  checkRequestErrors('phone'),
                  SizedBox(
                    height: Helper().getHeight(20),
                  ),
                  (processing)
                      ? const CircularProgressIndicator()
                      : buttonWidget(
                          text: "Continue",
                          onPressed: () {
                            _sendPhoneOtp();
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

  _sendPhoneOtp() async {
    setState(() {
      requestErrors = null;
    });

    if (_sendPhoneOtpFormKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var phoneData = {
        "phone": phoneController.text,
      };

      try {
        var response = await ApiClient()
            .httpPostRequest(ApiEndpoints.sendPhoneOtp, phoneData);

        setState(() {
          processing = false;
        });

        if (response["status"] == true) {
          Navigator.pop(context);
          enterPhoneOtp(phone: phoneController.text);
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
