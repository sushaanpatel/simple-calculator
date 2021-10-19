import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

var display = '';
var history = '';
var ans = '';
bool dis_ans = false;

class Calcu extends StatefulWidget {
  @override
  _calcustate createState() => _calcustate();
}

class _calcustate extends State<Calcu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff222222),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Center(
          child: Column(children: [
            Stack(children: <Widget>[
              Container(
                  height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xff424242),
                    borderRadius: BorderRadius.circular(20),
                  )),
              GestureDetector(
                onTap: () => gethistory(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 100, 64, 34),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(history,
                        style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey)),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 155, 64, 34),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(display,
                          style: GoogleFonts.montserrat(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)))),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CalcuButton(text: '1', onpress: addnum),
              CalcuButton(text: '2', onpress: addnum),
              CalcuButton(text: '3', onpress: addnum),
              CalcuButton(text: '+', onpress: addop)
            ]),
            SizedBox(width: 15, height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CalcuButton(text: '4', onpress: addnum),
              CalcuButton(text: '5', onpress: addnum),
              CalcuButton(text: '6', onpress: addnum),
              CalcuButton(text: '-', onpress: addop)
            ]),
            SizedBox(width: 15, height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CalcuButton(text: '7', onpress: addnum),
              CalcuButton(text: '8', onpress: addnum),
              CalcuButton(text: '9', onpress: addnum),
              CalcuButton(text: 'x', onpress: addop)
            ]),
            SizedBox(width: 15, height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CalcuButton(text: '0', onpress: addnum),
              CalcuButton(text: '.', onpress: addnum),
              CalcuButton(text: 'C', onpress: clear),
              CalcuButton(text: '/', onpress: addop)
            ]),
            SizedBox(width: 15, height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Textbtn(text: 'ANS', onpress: addans),
              Textbtn(text: 'AC', onpress: clearall),
              EnterButton(text: "=", onpress: eval)
            ])
          ]),
        ))));
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void addnum(String x) {
    if (dis_ans) {
      setState(() => display = '');
      setState(() => display += x);
      dis_ans = false;
    } else {
      setState(() => display += x);
    }
  }

  void addop(String x) {
    if (dis_ans) {
      setState(() => display = '');
      dis_ans = false;
    }
    setState(() => display += ' $x ');
  }

  void addans(String x) {
    setState(() => display += ans);
    dis_ans = false;
  }

  void clearall(String x) {
    setState(() => history = '');
    setState(() => display = '');
  }

  void gethistory() {
    setState(() => display = history);
    dis_ans = false;
  }

  void clear(String x) {
    setState(() => display = '');
  }

  void eval(String y) {
    setState(() {
      if (y != Null) {
        double _out = 0.0;
        history = y;
        List x = y.split(' ');
        if (x.length == 3) {
          if (x[1] == "+") {
            _out = double.parse(x[0]) + double.parse(x[2]);
          } else if (x[1] == "-") {
            _out = double.parse(x[0]) - double.parse(x[2]);
          } else if (x[1] == "x") {
            _out = double.parse(x[0]) * double.parse(x[2]);
          } else if (x[1] == "/") {
            _out = double.parse(x[0]) / double.parse(x[2]);
          }
          dis_ans = true;
          String d = _out.toString();
          if (d.split(' ').length == 1) {
            ans = roundDouble(_out, 8).toString();
            display = roundDouble(_out, 8).toString();
          } else {
            ans = 'Error';
            display = 'Error';
          }
        }
      } else {
        ans = 'Error';
        display = 'Error';
      }
    });
  }
}

class CalcuButton extends StatelessWidget {
  final String text;
  final Function onpress;

  const CalcuButton({
    required this.text,
    required this.onpress,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xff424242),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            fixedSize: Size(80, 80)),
        onPressed: () => onpress(text),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 25, fontWeight: FontWeight.w800),
          ),
        ));
  }
}

class EnterButton extends StatelessWidget {
  final String text;
  final Function onpress;

  const EnterButton({
    required this.text,
    required this.onpress,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xff424242),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            fixedSize: Size(130, 80)),
        onPressed: () => onpress(display),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 25, fontWeight: FontWeight.w800),
          ),
        ));
  }
}

class Textbtn extends StatelessWidget {
  final String text;
  final Function onpress;

  const Textbtn({
    required this.text,
    required this.onpress,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xff424242),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            fixedSize: Size(100, 80)),
        onPressed: () => onpress(text),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ));
  }
}
