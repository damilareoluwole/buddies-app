// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:buddies/models/interest.dart';
import 'package:buddies/screens/auth/widget/signin_with_social.dart';
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
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool processing = false;
  List<int> selectedInterestIds = [];

  @override
  void initState() {
    requestErrors = null;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        backgroundColor: AppTheme.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "",
          style: AppTheme.callout,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: Helper().getHeight(5),
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: AppTheme.authHeader,
                      ),
                      Text(
                        "New User",
                        style: AppTheme.footnote
                            .copyWith(color: AppTheme.redColor),
                      ),
                    ],
                  )),
              SizedBox(
                height: Helper().getHeight(5),
              ),
              Container(
                padding: AppTheme.containerPadding,
                child: Column(
                  children: [
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          TextFieldWidget(
                            hasIcon: true,
                            hintText: "Name",
                            controller: nameController,
                            validator: (value) {
                              return Validator().validate(value);
                            },
                          ),
                          checkRequestErrors('name'),
                          TextFieldWidget(
                            hasIcon: true,
                            hintText: "Email",
                            validator: (value) {
                              return Validator().validateEmail(value);
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ),
                          checkRequestErrors('email'),
                          TextFieldWidget(
                            hasIcon: true,
                            hintText: "Phone Number",
                            validator: (value) {
                              return Validator().validatePhone(value);
                            },
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                          ),
                          checkRequestErrors('phone'),
                          MultiSelectDialogField(
                            validator: (values) {
                              return Validator().validateInterest(values);
                            },
                            selectedColor: AppTheme.redColor,
                            buttonText: const Text("Select your Interests"),
                            decoration: BoxDecoration(
                              // Border radius
                              border: Border.all(
                                color: AppTheme.textInputColor, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            title: const Text("Select your Interests"),
                            items: interests
                                .map((interest) => MultiSelectItem<int>(
                                    interest.id, interest.name))
                                .toList(),
                            listType: MultiSelectListType.LIST,
                            onConfirm: (values) {
                              setState(() {
                                selectedInterestIds = values;
                              });

                              debugPrint(selectedInterestIds.toString());
                            },
                          ),
                          checkRequestErrors('interests'),
                          const SizedBox(
                            height: 12,
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Helper().getHeight(10),
                    ),
                    (processing)
                        ? const CircularProgressIndicator()
                        : buttonWidget(
                            text: "Sign Up",
                            onPressed: () {
                              register();
                            },
                          ),
                    SizedBox(
                      height: Helper().getHeight(12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
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
                                  .navigateToReplacement(Routes.login);
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontFamily: "inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.redColor,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const SizedBox(height: 30),
                    const SignInWithSocial(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  register() async {
    setState(() {
      requestErrors = null;
    });

    if (_registerFormKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var userData = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "interests": selectedInterestIds
      };

      debugPrint(userData.toString());

      try {
        var response =
            await ApiClient().httpPostRequest(ApiEndpoints.signUp, userData);

        setState(() {
          processing = false;
        });

        if (response["status"] == true &&
            response["data"] != null &&
            response["data"]["user"] != null) {
          userId = response["data"]["user"]["id"];
          NavigationService.instance.navigateTo(Routes.verifyOtp);
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
