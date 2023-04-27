class Validator {
  String? validate(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'This field is required';
    }

    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }

    RegExp regExp = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

    if (regExp.hasMatch(email)) {
      return null;
    } else {
      return "Invalid email address";
    }
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Please enter your phone number';
    }

    RegExp regExp = RegExp(r"^(070|080|081|090|091)\d{8}$");

    if (!regExp.hasMatch(phone)) {
      return "Invalid phone number";
    }

    return null;
  }

  String? validateInterest(List<int>? values) {
    if (values == null || values.length == 0) {
      return 'You must have at least one interest.';
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < 6) {
      return 'Password can not be less than 6 characters';
    }

    return null;
  }

  String? validateOpt(String? otp) {
    if (otp == null || otp.isEmpty) {
      return 'Please enter the OTP sent to you';
    }

    if (otp.length != 4) {
      return 'OTP must be 4 digits';
    }

    return null;
  }

  String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm password';
    }

    if (confirmPassword.length < 6) {
      return 'Password can not be less than 6 characters';
    }

    if (confirmPassword != password) {
      return 'Password does not match';
    }

    return null;
  }
}
