import 'package:flutter/material.dart';
import 'constants.dart';
import 'blocs/themes.dart';
import 'package:provider/provider.dart';
import 'history.dart';
import 'package:math_expressions/math_expressions.dart';

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
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "/History": (BuildContext context) => new History()
      },
    );
  }
}

final input = TextEditingController();
final List<String> historyList = <String>[];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choices) {
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
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hasFloatingPlaceholder: true,
                  hintText: "0",
                  hintStyle: TextStyle(
                    fontSize: 60,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextStyle(fontSize: 60),
                textAlign: TextAlign.right,
                controller: input,
              ),
            ),
            new Expanded(
              child: new Divider(),
            ),
            Column(children: <Widget>[
              new Row(
                children: <Widget>[
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  delete()
                ],
              ),
              new Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("/")
                ],
              ),
              new Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("*")
                ],
              ),
              new Row(
                children: <Widget>[
                  buildButton("0"),
                  buildButton("."),
                  operation("="),
                  buildButton("-")
                ],
              ),
              new Row(
                children: <Widget>[clean("AC"), buildButton("+")],
              ),
            ])
          ],
        ),
      ),
    );
  }

  chooseAction(String choices) {
    if (choices == Constants.history) {
      Navigator.of(context).pushNamed("/History");
    }
    if (choices == Constants.chooseTheme) {
      createDialogAlert(context);
    }
  }

  createDialogAlert(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;

        return AlertDialog(
          title: Text("Choose theme",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  2,
                  (int index) {
                    String text = "";
                    if (index == 0) {
                      text = "Light";
                    } else if (index == 1) {
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
                child: Text("OK"),
                onPressed: () {
                  if (selectedRadio == 0) {
                    ThemeChanger _themeChanger =
                        Provider.of<ThemeChanger>(context);
                    _themeChanger.setTheme(ThemeData.light());
                    Navigator.of(context).pop();
                  }
                  if (selectedRadio == 1) {
                    ThemeChanger _themeChanger =
                        Provider.of<ThemeChanger>(context);
                    _themeChanger.setTheme(ThemeData.dark());
                    Navigator.of(context).pop();
                  }
                })
          ],
        );
      },
    );
  }

  Widget buildButton(String text) {
    return Expanded(
      child: OutlineButton(
          padding: EdgeInsets.all(18.0),
          borderSide: BorderSide(color: Colors.white),
          color: Colors.white,
          child: Text(text, style: TextStyle(fontSize: 28.0)),
          onPressed: () {
            setState(() {
              input.text = input.text + text;
            });
          }),
    );
  }

  Widget clean(String text) {
    return Expanded(
        child: OutlineButton(
            padding: EdgeInsets.all(18.0),
            borderSide: BorderSide(color: Colors.white),
            child: Text(text, style: TextStyle(fontSize: 28.0)),
            onPressed: () {
              setState(() {
                input.text = "";
              });
            }));
  }

  Widget operation(String text) {
    return Expanded(
      child: OutlineButton(
          padding: EdgeInsets.all(18.0),
          borderSide: BorderSide(color: Colors.white),
          child: Text(text, style: TextStyle(fontSize: 28.0)),
          onPressed: () {
            setState(() {
              Parser p = new Parser();
              Expression exp = p.parse(input.text);
              ContextModel cm = new ContextModel();
              input.text = exp.evaluate(EvaluationType.REAL, cm).toString();
              historyList.add(exp.toString() +
                  " = " +
                  exp.evaluate(EvaluationType.REAL, cm).toString());
            });
          }),
    );
  }

  Widget delete() {
    return Expanded(
      child: OutlineButton(
        padding: EdgeInsets.all(18.0),
        borderSide: BorderSide(color: Colors.white),
        child: Icon(Icons.delete_forever, size: 35, color: Colors.blueGrey),
        onPressed: () {
          input.text = (input.text.length > 0)
              ? (input.text.substring(0, input.text.length - 1))
              : "";
        },
      ),
    );
  }

  Widget multiply(String text) {
    return Expanded(
      child: OutlineButton(
          padding: EdgeInsets.all(18.0),
          borderSide: BorderSide(color: Colors.white),
          child: Text(text, style: TextStyle(fontSize: 28.0)),
          onPressed: () {
            setState(() {
              Parser p = new Parser();
              Expression exp = p.parse(input.text);
              ContextModel cm = new ContextModel();
              input.text = exp.evaluate(EvaluationType.REAL, cm).toString();
              historyList.add(exp.toString() +
                  " x " +
                  exp.evaluate(EvaluationType.REAL, cm).toString());
            });
          }),
    );
  }
}
