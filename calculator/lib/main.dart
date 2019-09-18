import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';
import 'history.dart';
import 'blocs/themes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
        builder: (_) => ThemeChanger(ThemeData.light()),
        child: new MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
    title: 'Calculator',
    theme: theme.getTheme(),
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
      routes: <String, WidgetBuilder> {
    "/History" : (BuildContext context) => new History()
      },

    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 class _MyHomePageState extends State<MyHomePage> {


  String output = "0";
  int selectedRadio = 0;
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

 
  buttonPressed(String buttonText){

    if(buttonText == "AC"){

    _output = "0";
    num1 = 0;
    num2 = 0;
    operand = "";

    } else if(buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "x"){

      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";

    }else if(buttonText == "."){

      if(_output.contains(".")){
        return;

      } else {
        _output = _output + buttonText;
      }

    } else if(buttonText == "="){
      num2 = double.parse(output);
      if(operand == "+"){
        _output = (num1+num2).toString();
      }
      if(operand == "-"){
        _output = (num1-num2).toString();
      }
      if(operand == "/"){
        _output = (num1/num2).toString();
      }
      if(operand == "x"){
        _output = (num1*num2).toString();
      }
      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });

  }

  chooseAction(String choices){
    if(choices == Constants.history){
      Navigator.of(context).pushNamed("/History");
    }
    if(choices == Constants.chooseTheme){
      createDialogAlert(context);

    }
}
  createDialogAlert(BuildContext context){
   showDialog<void>(
  context: context,
  builder: (BuildContext context) {
    int selectedRadio = 0;
  
    return AlertDialog(
      title: Text("Choose theme", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(2, (int index) {
               String text = "";
               if(index==0){
                 text = "Light";

               } else if(index ==1){
                 text = "Dark Theme";
               }
               return RadioListTile(
                title: Text("$text", style: TextStyle(fontSize: 18)),
                value: index,
                groupValue: selectedRadio,
                onChanged: (int value) {
                  setState(() => selectedRadio = value);
                },
                
                
              );
  
            },
            ),
            
          );
        },
      ),
      actions: <Widget>[
        new FlatButton(
          child: Text("Cancel"),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            if(selectedRadio == 0){
              ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
              _themeChanger.setTheme(ThemeData.light());
              Navigator.of(context).pop();
            }
            if(selectedRadio == 1){
              ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
              _themeChanger.setTheme(ThemeData.dark());
              Navigator.of(context).pop();
            }
          }
            
        )
      ],
    );
  },
   );
  }
  Widget buildButton(String buttonText){
     return new Expanded(
          child: OutlineButton(
          padding: EdgeInsets.all(24.0),
          child: new Text(buttonText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
          onPressed: (){

            buttonPressed(buttonText);

          },
          ),
        );
  }
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        actions: <Widget>[
          Container(
                alignment: Alignment.topRight,
                child: PopupMenuButton<String>(
                onSelected: chooseAction,
                itemBuilder: (BuildContext context){
                  return Constants.choices.map((String choices){
                    return PopupMenuItem<String>(
                      value: choices,
                      child: Text(choices),
                    
                    );
                  }).toList();
                },

             
                ),
              ),
        ],
        
      ),
      body: Center(
        child: Column(
          children: <Widget>[
              
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0
              ),
              child: new Text(output, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)
              ),
              ),
         

            new Expanded(
              child: new Divider(),
            ),
            Column(
                
                children: <Widget>[ 
                new Row(
                
                children: <Widget>[
                
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/")

               
              ],),

               new Row(
                children: <Widget>[
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("x")


               
              ],),

               new Row(
                children: <Widget>[
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-")


               
              ],),

               new Row(
                children: <Widget>[
                buildButton("."),
                buildButton("0"),
                buildButton("00"),
                buildButton("+")

               
              ],),

               new Row(
                children: <Widget>[
                buildButton("AC"),
                buildButton("="),
           

               
              ],),
            ])
        
           
          ],
        ),
      ),
    );
  }
}
