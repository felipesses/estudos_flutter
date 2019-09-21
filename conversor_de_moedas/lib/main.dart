import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double calculo = 0.0;
  double r = 0.0; // REAL
  double d = 0.0; //DOLAR

  calcReal(double dolar, double real) {
    setState(() {
      calculo = dolar = (real * 4.3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Conversor de Moedas",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        backgroundColor: Colors.blueGrey,
        body: new Container(
          padding: EdgeInsets.only(top: 0, left: 25, right: 25),
          child: new ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              IconButton(
                icon: Icon(Icons.settings),
                alignment: Alignment.topRight,
                color: Colors.white,
                onPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Image.asset("assets/converter.png"),
                width: 140,
                height: 140,
              ),
              Text(
                "Currency Converter",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.grey),
                onChanged: (text) {
                  r = double.parse('$text');
                  calcReal(d, r);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  hintText: "USD",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                  alignLabelWithHint: true,
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.horizontal(),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 40),
                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.horizontal(),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 40),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                enabled: false,
                onChanged: (text) {
                  calcReal(d, r);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  labelText: '$calculo',
                  labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                  alignLabelWithHint: true,
                  disabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.horizontal(),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 40),
                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.horizontal(),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 40),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "1 USD = 4.3 BRL as of Aug 16, 2019",
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              FlatButton.icon(
                  icon: Icon(
                    Icons.loop,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Reverse Currencies',
                    style: new TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
