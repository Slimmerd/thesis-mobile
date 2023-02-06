import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListView(children: [
        Container(
          child: Row(children: [
            SizedBox(
              height: 40,
              width: 40,
            ),
            Text('73.6kg CO2 saved')
          ]),
        )
      ]),
    );
  }
}
