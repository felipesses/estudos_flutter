import 'package:flutter/material.dart';
import './firstPage.dart' as first;
import './secondPage.dart' as second;
import './thirdPage.dart' as third;

void main() {
  runApp(new MaterialApp(
  home: new MyTab()
  ));
}



class MyTab extends StatefulWidget {
  @override
  _MyTabState createState() => new _MyTabState();
}

class _MyTabState extends State<MyTab> with SingleTickerProviderStateMixin {




// controller para tab bar
  TabController controller;


  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3 /*QTD DE BARS */);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tab Bar"),
        backgroundColor: Colors.amber,
        bottom: new TabBar(
            // adicionando tab bar

            controller: controller,

            
            tabs: <Tab>[
              new Tab(text: "Home"),
              new Tab(text: "Pizza"),
              new Tab(text: "Lanches"),
            ]),
      ),

/*


    TAB BAR NA PARTE DE BAIXO

      bottomNavigationBar: new Material(
        color: Colors.black,
        child: new TabBar(
          controller: controller,
          tabs: <Tab>[

          new Tab(text: "Home"),
          new Tab(text: "Pizza"),
          new Tab(text: "Lanches"),

            
          ]
        ),
      ),

*/
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new first.First(),
          new second.Second(),
          new third.Third()
        ],
      ),
    );
  }
}
