import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.local_pizza),
                iconSize: 150.0,
                color: Colors.redAccent,
                onPressed: () {},
              ),
              new Text(
                "Pizza",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
