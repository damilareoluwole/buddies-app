import 'package:flutter/material.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/settings/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 4), () async {
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.blackColor,
        child: Center(
          child: SizedBox(
            width: Helper().getWidth(300),
            child: Center(
              child: Image.asset('assets/images/logo_black.png'),
            ),
          ),
        ),
      ),
    );
  }
}
