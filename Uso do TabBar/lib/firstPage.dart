import 'package:flutter/material.dart';


class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(

        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.accessibility_new),
                iconSize: 150.0,
                color: Colors.brown,
                onPressed: (){
                  
                },
              
              ),
              new Text(
                
                "Acessibilidade",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                
                  
                  fontSize: 50.0
                  ),

                
              
              )
            ],
          ),
        ),
      ),
    );
  }
}
