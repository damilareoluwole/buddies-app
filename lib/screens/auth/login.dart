import 'package:flutter/material.dart';
import 'package:buddies/models/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buddies/screens/auth/widget/signin_with_social.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/screens/widget/check_box.dart';
import 'package:buddies/screens/widget/text_field.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/services/validator.dart';
import 'package:buddies/settings/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool processing = false;
  var rememberMe = false;

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
          "",
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
                  height: Helper().getHeight(42),
                  width: Helper().getWidth(178),
                  child: Image.asset('assets/images/logo_white.png'),
                ),
              ),
              SizedBox(
                height: Helper().getHeight(30),
              ),
              Container(
                padding: AppTheme.containerPadding,
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        hasIcon: true,
                        hintText: "Phone/Email",
                        validator: (value) {
                          var phone = Validator().validatePhone(value);
                          var email = Validator().validateEmail(value);
                          if (phone == null) {
                            return null;
                          } else if (email == null) {
                            return null;
                          } else {
                            return 'Invalid phone or email';
                          }
                        },
                        controller: usernameController,
                      ),
                      checkRequestErrors('username'),
                      SizedBox(
                        height: Helper().getHeight(10),
                      ),
                      TextFieldWidget(
                        isPassword: true,
                        hintText: "Password",
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
                      Row(
                        children: [
                          Expanded(
                            child: CheckBox(
                              initial: rememberMe,
                              text: 'Remember Me',
                              onChanged: (value) {
                                rememberMe = value;
                              },
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                excludeFromSemantics: true,
                                child: Text(
                                  'Forgot password?',
                                  style: AppTheme.caption2
                                      .copyWith(color: HexColor('##4D4D4D')),
                                ),
                                onTap: () {
                                  NavigationService.instance
                                      .navigateTo(Routes.forgotPassword);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Helper().getHeight(70),
                      ),
                      (processing)
                          ? Helper().circularProgressIndicator()
                          : buttonWidget(
                              text: "Sign in",
                              onPressed: () {
                                login();
                              }),
                      SizedBox(
                        height: Helper().getHeight(12),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(
                              fontFamily: "inter",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.textInputHintColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              NavigationService.instance
                                  .navigateTo(Routes.register);
                            },
                            child: Text(
                              "Sign up as",
                              style: TextStyle(
                                fontFamily: "inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.redColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      const SizedBox(height: 30),
                      const SignInWithSocial(),
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

  login() async {
    setState(() {
      requestErrors = null;
    });
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var loginData = {
        "username": usernameController.text,
        "password": passwordController.text
      };

      try {
        var response =
            await ApiClient().httpPostRequest(ApiEndpoints.login, loginData);

        setState(() {
          processing = false;
        });

        if (response["status"] == true && response["data"] != null) {
          userId = response["data"]["user"]["id"];
          authUserToken = response["data"]["authorization"]["token"];
          user = User.fromJson(response["data"]["user"]);
          NavigationService.instance
              .navigateToReplacementUntil(Routes.dashboard);
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
