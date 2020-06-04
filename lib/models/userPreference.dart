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
  String totalSolved;
  String favourite;
  String imageUrl = imageUrlOfRegister;

  UserPreference(
      {this.userType,
      this.name,
      this.gender,
      this.dob,
      this.email,
      this.imageUrl,
      this.phone,
      this.institution,
      this.solvingString,
      this.totalSolved,
      this.favourite});
}

class User {
  final uid;
  User({this.uid});
}
