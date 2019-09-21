import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      title: "Collapsing",
      home: HomePage(),
    ));
