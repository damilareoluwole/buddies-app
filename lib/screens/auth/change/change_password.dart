import 'package:buddies/models/user.dart';
import 'package:flutter/material.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/screens/widget/text_field.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/validator.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _changePasswordFormKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var processing = false;

  @override
  void initState() {
    requestErrors = null;
    super.initState();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 450,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Helper().getWidth(24),
                vertical: Helper().getHeight(24),
              ),
              child: Form(
                key: _changePasswordFormKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      isPassword: true,
                      hintText: "Enter your current Password",
                      validator: (value) {
                        return Validator().validatePassword(value);
                      },
                      keyboardType: TextInputType.visiblePassword,
                      controller: currentPasswordController,
                    ),
                    checkRequestErrors('current_password'),
                    TextFieldWidget(
                      isPassword: true,
                      hintText: "Enter your new Password",
                      validator: (value) {
                        return Validator().validatePassword(value);
                      },
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                    ),
                    checkRequestErrors('password'),
                    TextFieldWidget(
                      isPassword: true,
                      hintText: "Confim your new Password",
                      validator: (value) {
                        return Validator().validateConfirmPassword(
                            passwordController.text, value);
                      },
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                    ),
                    checkRequestErrors('password'),
                    SizedBox(
                      height: Helper().getHeight(20),
                    ),
                    (processing)
                        ? Helper().circularProgressIndicator()
                        : buttonWidget(
                            text: "Continue",
                            onPressed: () {
                              _changePassword();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _changePassword() async {
    setState(() {
      requestErrors = null;
    });

    if (_changePasswordFormKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var data = {
        "current_password": currentPasswordController.text,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
      };

      try {
        var response = await ApiClient()
            .httpPostRequest(ApiEndpoints.changePassword, data);

        setState(() {
          processing = false;
        });

        if (response["status"] == true) {
          Navigator.pop(Helper().getContext());
          Helper().showSuccessfulSnackBar(
              "Password has been changed. Login to continue.");
          user.destroy();
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
