import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculo de IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double imc = 0.0;
  double a = 0.0, p = 0.0;

  calcIMC(double altura, double peso) {
    setState(() {
      imc = peso / (altura * altura);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text) {
                a = double.parse("$text"); //  convertendo a String para double
              },
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: '0.0'),
            ),
            TextField(
              onChanged: (text) {
                p = double.parse("$text");
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '0.0',
              ),
            ),
            new Text('Seu IMC é:'),
            Text(
              '$imc',
              style: Theme.of(context).textTheme.display1,
            ),
            new RaisedButton(
              color: Colors.blue,
              elevation: 4.0,
              splashColor: Colors.blueAccent,
              child: Text("Calcular"),
              textColor: Colors.white,
              onPressed: () {
                calcIMC(a, p);
              },
            ),
          ],
        ),
      ),
    );
  }
}
