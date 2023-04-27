// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:buddies/screens/auth/change/change_password.dart';
import 'package:buddies/screens/auth/change/change_send_email_otp.dart';
import 'package:buddies/screens/auth/change/change_send_phone_otp.dart';
import 'package:buddies/screens/auth/change/change_verify_otp.dart';
import 'package:buddies/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:buddies/models/user.dart';
import 'package:buddies/screens/frame/app_frame.dart';
import 'package:buddies/screens/widget/drop_down_headline.dart';
import 'package:buddies/screens/widget/logout.dart';
import 'package:buddies/settings/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      currentIndex: 2,
      title: "Setttings",
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account Management",
              style: AppTheme.settingsHeader,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/settings/account_type.svg"),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: AppTheme.settingsHeader.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user.email,
                          style: AppTheme.settingsHeader.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  color: AppTheme.redColor,
                  child: TextButton(
                    onPressed: () {
                      showDialog<void>(
                        context: Helper().getContext(),
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("You are about to change your email",
                                textAlign: TextAlign.center),
                            content: ChangeSendEmailOtp(),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Text(
                        "Change Email",
                        style: AppTheme.caption2.copyWith(
                          color: AppTheme.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/settings/account_type.svg"),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone",
                          style: AppTheme.settingsHeader.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user.phone,
                          style: AppTheme.settingsHeader.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  color: AppTheme.redColor,
                  child: TextButton(
                    onPressed: () {
                      showDialog<void>(
                        context: Helper().getContext(),
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text(
                                "You are about to change your phone number",
                                textAlign: TextAlign.center),
                            content: ChangeSendPhoneOtp(),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Text(
                        "Change Phone",
                        style: AppTheme.caption2.copyWith(
                          color: AppTheme.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/settings/account_type.svg"),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: AppTheme.settingsHeader.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "**********",
                          style: AppTheme.settingsHeader.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  color: AppTheme.redColor,
                  child: TextButton(
                    onPressed: () {
                      showDialog<void>(
                        context: Helper().getContext(),
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("You are about to change your password",
                                textAlign: TextAlign.center),
                            content: ChangePassword(),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Text(
                        "Change Password",
                        style: AppTheme.caption2.copyWith(
                          color: AppTheme.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Help and Safety",
              style: AppTheme.settingsHeader.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            twoColumnHeadline(title: "Help center", onTap: () {}),
            twoColumnHeadline(title: "Community guidelines", onTap: () {}),
            twoColumnHeadline(title: "Notifications", onTap: () {}),
            SizedBox(
              height: 25,
            ),
            Text(
              "Legal",
              style: AppTheme.settingsHeader.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            twoColumnHeadline(title: "About us", onTap: () {}),
            twoColumnHeadline(title: "FAQ", onTap: () {}),
            twoColumnHeadline(title: "Emergency contact", onTap: () {}),
            twoColumnHeadline(title: "Privacy policy", onTap: () {}),
            twoColumnHeadline(title: "Terms of use", onTap: () {}),
            twoColumnHeadline(title: "Cookie policy", onTap: () {}),
            twoColumnHeadline(title: "Career with us", onTap: () {}),
            SizedBox(
              height: 25,
            ),
            Text(
              "Application",
              style: AppTheme.settingsHeader.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            twoColumnHeadlineWithSvg(
                title: "Rate us",
                onTap: () {},
                image: "assets/icons/settings/rate_us.svg"),
            twoColumnHeadlineWithSvg(
                title: "Logout",
                onTap: () {
                  showModal(context);
                },
                image: "assets/icons/settings/logout.svg"),
            twoColumnHeadlineWithSvg(
                title: "Delete my account",
                onTap: () {},
                image: "assets/icons/settings/delete_account.svg"),
          ],
        ),
      ),
    );
  }
}

validateOtp({required action, required value}) {
  showDialog<void>(
    context: Helper().getContext(),
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Enter OTP to continue", textAlign: TextAlign.center),
        content: ChangeEnterOtp(action: action, value: value),
      );
    },
  );
}
