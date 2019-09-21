import 'package:flutter/material.dart';

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.restaurant_menu),
                iconSize: 150.0,
                color: Colors.blueAccent,
                onPressed: () {},
              ),
              new Text(
                "Restaurante",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
