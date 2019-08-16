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

  calcMoeda(double dolar, double real){ 
    setState(() {
    
    calculo = dolar = (real*4.3);

      
    });


  }
  

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
 
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Moedas"),
      
        backgroundColor: Colors.blue,
      ),
      

      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            TextField(
              onChanged: (text){
                r = double.parse('$text');

              },
              decoration: InputDecoration(
                hintText: "Digite o valor em dólares"
              ),

            ),

                SizedBox(height: 5,),

            new Text(
              "Valor em Real: "),
              Text(
                '$calculo',
              style: Theme.of(context).textTheme.display1,
                
                ),

            new RaisedButton(
              child: Text("Calcular"),
              elevation: 4.0,
              splashColor: Colors.amberAccent,
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){

                calcMoeda(d, r);



              },
            ),

        

          ],
        ),
      ),
      
      
    ),

    );
  }
}
