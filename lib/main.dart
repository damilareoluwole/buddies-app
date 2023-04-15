import 'package:flutter/material.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';
import 'package:buddies/settings/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    AppTheme.setTextTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buddies',
      theme: ThemeData(
        fontFamily: AppTheme.fontName,
        primarySwatch: Colors.blue,
      ),
      navigatorKey: NavigationService.instance.navigationKey,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      routes: routes(),
    );
  }
}
