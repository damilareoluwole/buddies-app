import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/settings/app_theme.dart';

class SignInWithSocial extends StatelessWidget {
  const SignInWithSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign in with social networks:",
          style:
              AppTheme.caption2b.copyWith(color: AppTheme.textInputHintColor),
        ),
        SizedBox(
          height: Helper().getHeight(10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/facebook.svg"),
            SizedBox(
              width: Helper().getWidth(10),
            ),
            SvgPicture.asset("assets/icons/twitter.svg"),
            SizedBox(
              width: Helper().getWidth(10),
            ),
            SvgPicture.asset("assets/icons/gmail.svg"),
          ],
        ),
        SizedBox(
          height: Helper().getHeight(19),
        ),
        SizedBox(
          width: Helper().getWidth(180),
          child: Text(
            textAlign: TextAlign.center,
            "If you are creating a new account, Terms & Conditions and Privacy Policy will apply.",
            style: TextStyle(
              fontFamily: "inter",
              fontSize: 8,
              fontWeight: FontWeight.w400,
              color: AppTheme.textInputHintColor,
            ),
          ),
        ),
      ],
    );
  }
}
