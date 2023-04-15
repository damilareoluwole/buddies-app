import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buddies/models/user.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/settings/app_theme.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: Helper().getHeight(160),
        ),
        SizedBox(
          height: Helper().getHeight(200),
          width: Helper().getWidth(216),
          child: SvgPicture.asset("assets/icons/logout.svg"),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          "Are you Sure You Want To \nLog Out",
          style: AppTheme.resetHeader,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: Helper().getHeight(150),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: AppTheme.grey,
                height: 44,
                width: Helper().getWidth(140),
                child: TextButton(
                  onPressed: () {
                    Helper().popScreen(context);
                  },
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: AppTheme.button,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Helper().getWidth(30),
              ),
              Container(
                color: AppTheme.redColor,
                height: 44,
                width: Helper().getWidth(140),
                child: TextButton(
                  onPressed: () {
                    user.destroy();
                  },
                  child: Center(
                    child: Text(
                      "Sure",
                      style: AppTheme.button,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
