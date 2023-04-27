import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/timer_button.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/services/validator.dart';
import 'package:buddies/settings/app_theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final _verifyOtpFormKey = GlobalKey<FormState>();
  var code = '';
  var invalidMessage = '';
  final codeController = TextEditingController();
  bool processing = false;
  bool isProcessingResend = false;

  @override
  void initState() {
    requestErrors = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: AppBar(
            backgroundColor: AppTheme.whiteColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: SvgPicture.asset('assets/icons/chevron_left.svg'),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Helper().popScreen(context);
                }
              },
            ),
            centerTitle: true,
            title: Text(
              "Verify your phone number",
              style: AppTheme.callout,
            )),
        body: Container(
          padding: AppTheme.containerPadding,
          child: Column(
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                    child: Text(
                  textAlign: TextAlign.center,
                  "Enter your OTP code here",
                  style: AppTheme.footnote.copyWith(color: AppTheme.grey2),
                )),
              ),
              SizedBox(
                height: Helper().getHeight(30),
              ),
              Form(
                key: _verifyOtpFormKey,
                child: PinCodeTextField(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textStyle: AppTheme.callout,
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
                  animationDuration: const Duration(milliseconds: 900),
                  enableActiveFill: true,
                  controller: codeController,
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
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  style: AppTheme.footnote,
                  children: [
                    WidgetSpan(
                        child: Text(
                      "Didn’t receive the OTP?",
                      style: AppTheme.footnote,
                    )),
                    WidgetSpan(
                      child: (isProcessingResend)
                          ? Helper().circularProgressIndicator()
                          : TimerButton(
                              durration: 20,
                              child: InkWell(
                                //onTap: () => resendCode(),
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
                        verifyOtp();
                      },
                    ),
            ],
          ),
        ));
  }

  verifyOtp() async {
    setState(() {
      requestErrors = null;
    });

    if (_verifyOtpFormKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var otpData = {
        "otp": codeController.text,
        "userId": userId,
      };

      try {
        var response = await ApiClient()
            .httpPostRequest(ApiEndpoints.verifySignupOtp, otpData);

        setState(() {
          processing = false;
        });

        if (response["status"] == true && response["data"] != null) {
          userId = response["data"]["user"]["id"];
          _showModal();
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

  _showModal() {
    return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      shape: AppTheme.bottomSheetStyle,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: Helper().getHeight(160),
              ),
              SizedBox(
                height: Helper().getHeight(200),
                width: Helper().getWidth(216),
                child: SvgPicture.asset("assets/icons/account_created.svg"),
              ),
              SizedBox(
                height: Helper().getHeight(80),
              ),
              Text(
                "Account Created",
                style: AppTheme.resetHeader,
              ),
              SizedBox(
                height: Helper().getHeight(20),
              ),
              SizedBox(
                width: Helper().getWidth(266),
                child: Text(
                  textAlign: TextAlign.center,
                  "Your account has been created successfully.",
                  style: AppTheme.hintText.copyWith(color: AppTheme.greyColor),
                ),
              ),
              SizedBox(
                height: Helper().getHeight(150),
              ),
              buttonWidget(
                  text: "Done",
                  onPressed: () {
                    NavigationService.instance
                        .navigateToReplacementUntil(Routes.privacy);
                  }),
            ],
          ),
        );
      },
    );
  }
}
