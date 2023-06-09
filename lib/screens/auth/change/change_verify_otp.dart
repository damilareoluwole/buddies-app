// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:buddies/models/user.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/screens/widget/timer_button.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/services/validator.dart';
import 'package:buddies/settings/app_theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ChangeEnterOtp extends StatefulWidget {
  const ChangeEnterOtp({super.key, required this.action, required this.value});

  final String action;
  final String value;

  @override
  State<ChangeEnterOtp> createState() => _ChangeEnterOtpState();
}

class _ChangeEnterOtpState extends State<ChangeEnterOtp> {
  final _verifyEmailOtpFormKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  var isProcessingResend = false;
  var code = '';
  var invalidMessage = '';
  var processing = false;

  @override
  void initState() {
    requestErrors = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      padding: AppTheme.containerPadding,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              child: Text(
                textAlign: TextAlign.center,
                "To continue with your request, please enter the OTP sent to you here",
                style: AppTheme.footnote.copyWith(color: AppTheme.grey2),
              ),
            ),
          ),
          SizedBox(
            height: Helper().getHeight(15),
          ),
          Form(
            key: _verifyEmailOtpFormKey,
            child: PinCodeTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: AppTheme.callout,
              controller: otpController,
              validator: (value) {
                return Validator().validate(value);
              },
              appContext: context,
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                fieldHeight: 30,
                fieldWidth: 30,
                activeColor: AppTheme.textColor,
                activeFillColor: AppTheme.whiteColor,
                inactiveFillColor: AppTheme.whiteColor,
                selectedFillColor: Colors.transparent,
                disabledColor: AppTheme.textColor,
                selectedColor: AppTheme.textColor,
                inactiveColor: AppTheme.blackColor,
                fieldOuterPadding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                borderWidth: 2,
              ),
              cursorColor: AppTheme.textColor,
              obscuringWidget: Text(
                '●',
                style: AppTheme.callout,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onChanged: (value) {
                setState(() {
                  code = value;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
            ),
          ),
          checkRequestErrors('otp'),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              style: AppTheme.footnote,
              children: [
                WidgetSpan(
                  child: Text(
                    "Didn’t receive the OTP?",
                    style: AppTheme.footnote,
                  ),
                ),
                WidgetSpan(
                  child: (isProcessingResend)
                      ? Helper().circularProgressIndicator()
                      : TimerButton(
                          durration: 120,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              ' Resend',
                              style: AppTheme.footnote
                                  .copyWith(color: AppTheme.redColor),
                            ),
                          ),
                          counterWidget: (p0) => Text(
                            ' $p0',
                            style: AppTheme.footnote
                                .copyWith(color: AppTheme.redColor),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          (processing)
              ? Helper().circularProgressIndicator()
              : buttonWidget(
                  text: "Verify",
                  onPressed: () {
                    _verifyEmailOtp();
                  },
                ),
        ],
      ),
    );
  }

  _verifyEmailOtp() async {
    setState(() {
      requestErrors = null;
    });

    if (_verifyEmailOtpFormKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      String api;
      Map<String, String> data;

      if (widget.action == "email") {
        api = ApiEndpoints.changeEmail;
        data = {"otp": otpController.text, "email": widget.value};
      } else {
        api = ApiEndpoints.changePhone;
        data = {"otp": otpController.text, "phone": widget.value};
      }

      try {
        var response = await ApiClient().httpPostRequest(api, data);

        setState(() {
          processing = false;
        });

        if (response["status"] == true && response["data"] != null) {
          Navigator.pop(context);
          setState(() {
            user = User.fromJson(response["data"]["user"]);
          });

          NavigationService.instance.navigateTo(Routes.settings);
          Helper().showSuccessfulSnackBar("Account updated successfully");
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
