import 'package:flutter/material.dart';
import 'calculator.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calcu(),
      debugShowCheckedModeBanner: false,
    );
  }
}
