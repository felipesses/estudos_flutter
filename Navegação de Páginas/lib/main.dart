import 'package:flutter/material.dart';


void main (){

  runApp(new MaterialApp(

    home: new HomePage(),
    routes: <String, WidgetBuilder> {
      "/SecondPage" : (BuildContext context) => new SecondPage()
    }


  ));

}



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Home"), backgroundColor: Colors.red,),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.favorite, color: Colors.red),
                iconSize: 70.0,
                onPressed: () {
                  Navigator.of(context).pushNamed("/SecondPage"); // push para a segunda pagina
                },
              ),
              new Text("Home")
            ],
          ),
        ),
      ),
    );
  }
}




// SEGUNDA PAGINA


class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Segunda Página"), backgroundColor: Colors.blue,),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.home, color: Colors.red),
                iconSize: 70.0,
                onPressed: (){
                  Navigator.of(context).pushNamed("/HomePage");
                },
              ),
              new Text("Second Page")
            ],
          ),
        ),
      ),
    );
  }
}

