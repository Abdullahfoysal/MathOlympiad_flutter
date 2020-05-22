import 'package:flutter/material.dart';

class AppBarDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            titleSpacing: 20.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.blueAccent,
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                'I\'m poor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: () {
                  print('clicked');
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_alert),
                onPressed: () {
                  print('clicked');
                },
              ),
              IconButton(
                icon: const Icon(Icons.art_track),
                onPressed: () {
                  print('clicked');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
