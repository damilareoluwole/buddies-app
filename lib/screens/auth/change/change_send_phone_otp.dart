import 'package:buddies/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/screens/widget/text_field.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/validator.dart';

class ChangeSendPhoneOtp extends StatefulWidget {
  const ChangeSendPhoneOtp({super.key});

  @override
  State<ChangeSendPhoneOtp> createState() => _ChangeSendPhoneOtpState();
}

class _ChangeSendPhoneOtpState extends State<ChangeSendPhoneOtp> {
  final _sendPhoneOtpFormKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
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
    return SingleChildScrollView(
      child: SizedBox(
      height: 300,
      child: Column(
        children: [
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
                    hintText: "Enter your Password",
                    validator: (value) {
                      return Validator().validatePassword(value);
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                  ),
                  checkRequestErrors('password'),
                  TextFieldWidget(
                    hasIcon: true,
                    hintText: "Enter new phone number",
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
                      ? Helper().circularProgressIndicator()
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
    ));
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
        "password": passwordController.text,
      };

      try {
        var response = await ApiClient()
            .httpPostRequest(ApiEndpoints.sendPhoneOtp, phoneData);

        setState(() {
          processing = false;
        });

        if (response["status"] == true) {
          Navigator.pop(Helper().getContext());
          validateOtp(action: "phone", value: phoneController.text);
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
