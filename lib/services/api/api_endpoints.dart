class ApiEndpoints {
  ApiEndpoints._();
  static var baseUrl = "http://167.172.181.74:9013/api/";
  static var interests = "interests";
  static var signUp = "auth/register";
  static var login = "auth/login";
  static var verifySignupOtp = "auth/register/activate";
  static var completeSignup = "auth/register/complete";
  static var editProfile= "user/profile/edit";
  static var confirmPassword = "user/confirm-password";
  static var sendEmailOtp = "user/change/email";
  static var sendPhoneOtp = "user/change/phone";
  static var changePhone = "user/change/phone/complete";
  static var changeEmail = "user/change/email/complete";
  static var resetSendOtp = "";
  static var resetInitiate = "auth/reset/password/initiate";
  static var resetValidate = "auth/reset/password/validate";
  static var changePassword = "user/change/password";

}
