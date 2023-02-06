import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Achievements')),
      body: ListView(children: [
        Container(
          child: Column(children: [
            Container(),
            Text('1kg CO2'),
          ]),
        )
      ]),
    );
  }
}
