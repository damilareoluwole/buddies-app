import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static NavigationService instance = NavigationService();

  GlobalKey<NavigatorState> getNavigationKey() {
    return navigationKey;
  }

  Future<dynamic> navigateToReplacement(String routeName) {
    debugPrint('navigating (replacement) to $routeName');
    return navigationKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    debugPrint('navigating to $routeName with');
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute routeName) {
    return navigationKey.currentState!.push(routeName);
  }

  Future<dynamic> navigateToReplacementUntil(String routeName) {
    return navigationKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  goback() {
    return navigationKey.currentState!.pop();
  }

  BuildContext getContext() {
    return NavigationService.instance.getNavigationKey().currentState!.context;
  }
}
