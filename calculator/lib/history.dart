import 'package:flutter/material.dart';
import 'main.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: new Center(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: historyList.map((data) => Text(data)).toList(),
        ),
      ),
    );
  }
}
