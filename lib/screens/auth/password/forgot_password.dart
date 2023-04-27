import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buddies/screens/auth/password/reset_password.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/screens/widget/text_field.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/validator.dart';
import 'package:buddies/settings/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

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
          "Forgot password",
          style: AppTheme.callout,
        ),
      ),
      body: Container(
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
                  "Please enter your email address. You will receive an otp to enable you create a new password via email.",
                  style:
                      AppTheme.hintText.copyWith(color: AppTheme.darkGreyColor),
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
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: TextFieldWidget(
                      hasIcon: true,
                      hintText: "Email",
                      validator: (value) {
                        return Validator().validateEmail(value);
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                  ),
                  checkRequestErrors('email'),
                  SizedBox(
                    height: Helper().getHeight(20),
                  ),
                  (isProcessing)
                      ? Align(
                          alignment: Alignment.center,
                          child: Helper().circularProgressIndicator(),
                        )
                      : buttonWidget(
                          text: "Send",
                          onPressed: () {
                            process();
                          },
                        ),
                ],
              ),
            ),
          ],
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

        var email = emailController.text;
        var response =
            await ApiClient().httpPostRequest(ApiEndpoints.resetInitiate, {
          'email': email,
        });
        debugPrint(response.toString());
        setState(() {
          isProcessing = false;
        });
        Navigator.push(
          Helper().getContext(),
          MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(email: email)),
        );
      } catch (e) {
        debugPrint(e.toString());

        setState(() {
          isProcessing = false;
        });
      }
    }
  }
}
