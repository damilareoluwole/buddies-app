import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buddies/screens/frame/app_frame.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/screens/widget/text_field.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/services/validator.dart';
import 'package:buddies/settings/app_theme.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final confirmPasswordConfirmController = TextEditingController();

  var isProcessing = false;

  @override
  void initState() {
    super.initState();
    requestErrors = null;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
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
          "Reset password",
          style: AppTheme.callout,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: Helper().getHeight(40),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Helper().getWidth(298),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Please a new password you would like to start using. You won't be able to reset again until a month.",
                    style: AppTheme.hintText
                        .copyWith(color: AppTheme.darkGreyColor),
                  ),
                ),
              ),
              SizedBox(
                height: Helper().getHeight(30),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Helper().getWidth(24),
                  vertical: Helper().getHeight(24),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        isPassword: true,
                        hintText: "Enter OTP sent to you",
                        validator: (value) {
                          return Validator().validateOpt(value);
                        },
                        keyboardType: TextInputType.number,
                        controller: otpController,
                      ),
                      checkRequestErrors('otp'),
                      TextFieldWidget(
                        isPassword: true,
                        hintText: "New Password",
                        validator: (value) {
                          return Validator().validatePassword(value);
                        },
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                      ),
                      checkRequestErrors('password'),
                      SizedBox(
                        height: Helper().getHeight(10),
                      ),
                      TextFieldWidget(
                        isPassword: true,
                        hintText: "Confirm New Password",
                        validator: (value) {
                          return Validator().validateConfirmPassword(
                              passwordController.text, value);
                        },
                        keyboardType: TextInputType.visiblePassword,
                        controller: confirmPasswordConfirmController,
                      ),
                      SizedBox(
                        height: Helper().getHeight(20),
                      ),
                      (isProcessing)
                          ? Align(
                              alignment: Alignment.center,
                              child: Helper().circularProgressIndicator(),
                            )
                          : buttonWidget(
                              text: "Change Password",
                              onPressed: () {
                                process();
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void process() async {
    if (isProcessing) return;

    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          requestErrors = null;
          isProcessing = true;
        });

        var response =
            await ApiClient().httpPostRequest(ApiEndpoints.resetValidate, {
          'email': widget.email,
          'otp': otpController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordConfirmController.text
        });
        debugPrint(response.toString());
        setState(() {
          isProcessing = false;
        });
        _showModal();
      } catch (e) {
        debugPrint(e.toString());

        setState(() {
          isProcessing = false;
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
          padding: containerPadding,
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
                child: SvgPicture.asset("assets/icons/password_key.svg"),
              ),
              SizedBox(
                height: Helper().getHeight(80),
              ),
              Text(
                "Your password has been reset",
                style: AppTheme.resetHeader,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Helper().getHeight(20),
              ),
              SizedBox(
                width: Helper().getWidth(266),
                child: Text(
                  textAlign: TextAlign.center,
                  "Kindly login with your new password",
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
                        .navigateToReplacementUntil(Routes.login);
                  }),
            ],
          ),
        );
      },
    );
  }
}
