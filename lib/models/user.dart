import 'package:buddies/models/interest.dart';
import 'package:buddies/services/api/api_client.dart';
import 'package:buddies/services/navigation_service.dart';
import 'package:buddies/services/routes/routes.dart';

var user = User.empty();

class User {
  int id;
  String name;
  String phone;
  String email;
  String avatar;
  String? address;
  dynamic dob;
  int onboardingInitiate;
  int onboardingOtp;
  int onboardingPrivacy;
  List<Interest> interest;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.dob,
    this.address,
    required this.onboardingInitiate,
    required this.onboardingOtp,
    required this.onboardingPrivacy,
    required this.interest,
  });

  @override
  String toString() {
    return 'User(id: $id, name: $name, phone: $phone, email: $email, avatar: $avatar, address:$address, $dob dob: $dob, onboardingInitiate: $onboardingInitiate, onboardingOtp: $onboardingOtp, onboardingPrivacy: $onboardingPrivacy, interest: $interest)';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        name: json['name'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        avatar: json['avatar'] as String,
        address: json['address'] as String?,
        dob: json['dob'] as dynamic,
        onboardingInitiate: json['onboardingInitiate'] as int,
        onboardingOtp: json['onboardingOtp'] as int,
        onboardingPrivacy: json['onboardingPrivacy'] as int,
        interest: (json['interest'] as List<dynamic>?)
                ?.map((e) => Interest.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'avatar': avatar,
        'dob': dob,
        'address': address,
        'onboardingInitiate': onboardingInitiate,
        'onboardingOtp': onboardingOtp,
        'onboardingPrivacy': onboardingPrivacy,
        'interest': interest.map((e) => e.toJson()).toList(),
      };

  factory User.empty() => User(
      id: 0,
      name: '',
      email: '',
      phone: '',
      avatar: '',
      dob: '',
      address: '',
      interest: [],
      onboardingInitiate: 0,
      onboardingOtp: 0,
      onboardingPrivacy: 0);

  destroy() {
    user = User.empty();
    userId = 0;
    interests = <Interest>[];
    interestsLoaded = false;
    authUserToken = '';
    NavigationService.instance.navigateToReplacementUntil(Routes.login);
  }
}
