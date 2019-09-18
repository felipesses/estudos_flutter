import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),

      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("History")
          ],
        ),
      ),

      
    );
  }
}