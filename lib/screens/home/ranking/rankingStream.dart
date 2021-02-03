import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/designs/ranking.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/services/user/userActivity.dart';

class RankingStream extends StatelessWidget {
  final UserActivity userActivity;

  RankingStream(this.userActivity);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserPreference>>.value(
      value: DatabaseService(email: userActivity.user.uid).userRankingStream,
      child: Scaffold(
        body: Container(
          child: Ranking(),
        ),
      ),
    );
  }
}
