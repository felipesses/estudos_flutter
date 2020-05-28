import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double real = 0.0;
  double dollar = 5.27;
  double result = 0.0;

  calculate(double real, double dollar) {
    setState(() {
      result = (real * dollar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        padding: EdgeInsets.only(top: 0, left: 25, right: 25),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            IconButton(
              onPressed: () {},
              alignment: Alignment.topRight,
              icon: Icon(Icons.settings),
              color: Colors.white,
            ),
            SizedBox(
              height: 140,
              width: 140,
              child: Image.asset(
                'images/converter.png',
              ),
            ),
            Text(
              'Currency Converter',
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (text) {
                real = double.parse('$text');
                calculate(real, dollar);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'USD',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 40,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 40,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 40,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              onChanged: (text) {
                calculate(real, dollar);
              },
              enabled: false,
              decoration: InputDecoration(
                labelText: '${result.toStringAsFixed(2)}',
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 40,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 40,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 40,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1 USD = 5.27 BRL AS OF AUG 28, 2020',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.loop,
                color: Colors.white,
              ),
              label: Text(
                'Reverse Currencies',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
