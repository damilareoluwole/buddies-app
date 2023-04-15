import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buddies/models/user.dart';
import 'package:buddies/screens/widget/button.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/api/api_endpoints.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/settings/app_theme.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool processing = false;

  @override
  void initState() {
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
          "Privacy",
          style: AppTheme.callout,
        ),
      ),
      body: Container(
        padding: AppTheme.containerPadding,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTheme.body.copyWith(color: AppTheme.grey2),
                  children: [
                    const TextSpan(
                      text:
                          'Your location is required for your profile to appear in search results. \n\nBy clicking on confirm you hereby agree to our ',
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'terms and conditions',
                          style:
                              AppTheme.body.copyWith(color: AppTheme.redColor),
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: ' and ',
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'privacy policy',
                          style:
                              AppTheme.body.copyWith(color: AppTheme.redColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            (processing)
                ? const CircularProgressIndicator()
                : buttonWidget(
                    text: "Confirm",
                    onPressed: () {
                      complete();
                    },
                  ),
          ],
        ),
      ),
    );
  }

  complete() async {
    setState(() {
      processing = true;
    });

    var otpData = {
      "userId": userId,
    };

    try {
      var response = await ApiClient()
          .httpPostRequest(ApiEndpoints.completeSignup, otpData);

      setState(() {
        processing = false;
      });

      if (response["status"] == true &&
          response["data"] != null &&
          response["data"]["user"] != null) {
        userId = response["data"]["user"]["id"];
        authUserToken = response["data"]["authorization"]["token"];
        user = User.fromJson(response["data"]["user"]);
        NavigationService.instance.navigateToReplacementUntil(Routes.dashboard);
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
