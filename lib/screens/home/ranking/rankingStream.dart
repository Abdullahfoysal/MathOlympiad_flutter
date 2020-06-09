import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/designs/ranking.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/database.dart';

class RankingStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserPreference>>.value(
      value: DatabaseService().userRankingStream,
      child: Scaffold(
        body: Container(
          child: Ranking(),
        ),
      ),
    );
  }
}
