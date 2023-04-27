// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buddies/models/user.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/screens/frame/app_frame.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/screens/widget/text_field.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/validator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _editProfileFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  bool processing = false;

  @override
  void initState() {
    nameController.text = user.name;
    phoneController.text = user.phone;
    emailController.text = user.email;
    addressController.text = user.address ?? "";
    requestErrors = null;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var radius = 160.0;
    return AppFrame(
      title: "Edit Profile",
      child: Padding(
        padding: containerPadding,
        child: Form(
          key: _editProfileFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: radius,
                  child: Stack(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/me.png',
                          fit: BoxFit.cover,
                          width: radius,
                          height: radius,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(
                            'assets/icons/camera.svg',
                            width: 48,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 36),
              TextFieldWidget(
                hasIcon: true,
                controller: nameController,
                hintText: 'Name',
                validator: (value) {
                  return Validator().validate(value);
                },
              ),
              checkRequestErrors('name'),
              TextFieldWidget(
                enabled: false,
                hasIcon: true,
                controller: emailController,
                hintText: 'Email',
                validator: (value) {
                  return Validator().validate(value);
                },
                keyboardType: TextInputType.emailAddress,
              ),
              checkRequestErrors('email'),
              TextFieldWidget(
                enabled: false,
                hasIcon: true,
                hintText: 'Phone',
                controller: phoneController,
                validator: (value) {
                  return Validator().validate(value);
                },
                keyboardType: TextInputType.phone,
              ),
              checkRequestErrors('phone'),
              TextFieldWidget(
                hasIcon: true,
                controller: addressController,
                hintText: 'Address',
                validator: (value) {
                  return Validator().validate(value);
                },
              ),
              checkRequestErrors('address'),
              SizedBox(height: 12),
              (processing)
                  ? Center(
                      child: Helper().circularProgressIndicator(),
                    )
                  : buttonWidget(
                      text: 'Save Changes',
                      onPressed: () {
                        editProfile();
                      }),
            ],
          ),
        ),
      ),
    );
  }

  editProfile() async {
    setState(() {
      requestErrors = null;
    });

    if (_editProfileFormKey.currentState!.validate()) {
      setState(() {
        processing = true;
      });

      var userData = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "address": addressController.text
      };

      debugPrint(userData.toString());

      try {
        var response = await ApiClient()
            .httpPostRequest(ApiEndpoints.editProfile, userData);

        setState(() {
          processing = false;
        });

        if (response["status"] == true &&
            response["data"] != null &&
            response["data"]["user"] != null) {
          user = User.fromJson(response["data"]["user"]);
          setState(() {
            Helper().showSuccessfulSnackBar(response["message"]);
          });
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
