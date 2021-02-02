import 'package:srmcapp/shared/constant.dart';

class UserPreference {
  String userType;
  String name;
  String gender;
  String dob;
  String email;
  String phone;
  String institution;
  String solvingString;
  int ranking;
  String bloodGroup;
  int totalSolved = 0;
  int totalWrong = 0;
  String favourite;
  String imageUrl = imageUrlOfRegister;
  String fcmToken;

  UserPreference({
    this.userType,
    this.name,
    this.gender,
    this.dob,
    this.email,
    this.imageUrl,
    this.phone,
    this.institution,
    this.solvingString,
    this.totalSolved,
    this.totalWrong,
    this.favourite,
    this.bloodGroup,
    this.ranking,
    this.fcmToken,
  });
}

class UserModel {
  final uid;
  final email;
  final bool emailVerified;
  UserModel({this.uid, this.email, this.emailVerified});
}
