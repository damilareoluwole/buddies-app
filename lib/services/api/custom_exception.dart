import 'package:dio/dio.dart';
import 'package:buddies/screens/widget/request_errors.dart';
import 'package:buddies/services/helper.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';

class ValidationException implements Exception {
  String message;
  Response<dynamic> response;

  ValidationException(this.message, this.response) {
    if (response.data != null) {
      if (response.data.containsKey('message')) {
        message = response.data['message'];
      }

      if (response.data.containsKey('errors')) {
        requestErrors = response.data['errors'];
      } else {
        requestErrors = response.data;
      }
    }
  }
}

class AuthTimeOutException implements Exception {
  AuthTimeOutException() {
    Helper().showErrorSnackBar("Unable to complete your request.");
  }
}

class AuthNoInternetException implements Exception {
  AuthNoInternetException() {
    Helper().showErrorSnackBar(
        "Unable to complete your request. Check your internet and try again.");
  }
}

class UnauthorisedException implements Exception {
  UnauthorisedException() {
    //user.destroy();
    NavigationService.instance.navigateToReplacementUntil(Routes.login);
    Helper().showErrorSnackBar("Invalid login credentials. Login to continue.");
  }
}
