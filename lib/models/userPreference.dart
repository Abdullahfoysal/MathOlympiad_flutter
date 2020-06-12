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
  });
}

class User {
  final uid;
  User({this.uid});
}
