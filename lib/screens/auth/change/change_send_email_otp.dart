import 'package:buddies/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/screens/widget/text_field.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/validator.dart';

class ChangeSendEmailOtp extends StatefulWidget {
  const ChangeSendEmailOtp({super.key});

  @override
  State<ChangeSendEmailOtp> createState() => _ChangeSendEmailOtpState();
}

class _ChangeSendEmailOtpState extends State<ChangeSendEmailOtp> {
  final _sendEmailOtpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var processing = false;

  @override
  void initState() {
    requestErrors = null;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
              key: _sendEmailOtpFormKey,
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
                    hintText: "Enter new email",
                    validator: (value) {
                      return Validator().validateEmail(value);
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  checkRequestErrors('email'),
                  SizedBox(
                    height: Helper().getHeight(20),
                  ),
                  (processing)
                      ? Helper().circularProgressIndicator()
                      : buttonWidget(
                          text: "Continue",
                          onPressed: () {
                            _sendEmailOtp();
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),);
  }

  _sendEmailOtp() async {
    setState(() {
      requestErrors = null;
    });

    if (_sendEmailOtpFormKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var emailData = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      try {
        var response = await ApiClient()
            .httpPostRequest(ApiEndpoints.sendEmailOtp, emailData);

        setState(() {
          processing = false;
        });

        if (response["status"] == true) {
          Navigator.pop(Helper().getContext());
          validateOtp(action: "email", value: emailController.text);
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
