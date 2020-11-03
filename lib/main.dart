import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Culculator());
}

class Culculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equ = "0";
  String result = "0";
  String expression = "";
  double equationFontsize = 38.0;

  double resultFontsiz = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equ ="0";
        result = "0";
        equationFontsize = 38.0;
        resultFontsiz = 48.0;
      } else if (buttonText == "<=") {
        equationFontsize = 48.0;
        resultFontsiz = 38.0;
        equ = equ.substring(0, equ.length - 1);
        if (equ == "") {
          equ = "0";
        }
      } else if (buttonText == "=") {
        equationFontsize = 38.0;
        resultFontsiz = 48.0;


        expression = equ;
        expression = expression.replaceAll('*', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm=ContextModel();
          result='${exp.evaluate(EvaluationType.REAL ,cm)}';
        } catch (e) {
          result = "error";

        }
      } else {
        equationFontsize = 48.0;
        resultFontsiz = 38.0;
        if (equ == "0") {
          equ = buttonText;
        } else {
          equ = equ + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color button , Color txt) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: button,
      child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: txt),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter simple Calculator"),
        centerTitle: true,
      ), 
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equ,
              style: TextStyle(
                  fontSize: equationFontsize, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                  fontSize: resultFontsiz, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("AC", 1, Colors.white , Colors.blue),
                        buildButton("<=", 1, Colors.white , Colors.blue),
                        buildButton("÷", 1, Colors.white , Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.white , Colors.black54),
                        buildButton("8", 1, Colors.white , Colors.black54),
                        buildButton("9", 1, Colors.white , Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.white , Colors.black54),
                        buildButton("5", 1, Colors.white , Colors.black54),
                        buildButton("6", 1, Colors.white , Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.white ,Colors.black54),
                        buildButton("2", 1, Colors.white , Colors.black54),
                        buildButton("3", 1, Colors.white , Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.white ,Colors.blue),
                        buildButton("0", 1, Colors.white , Colors.black54),
                        buildButton("00", 1, Colors.white , Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("*", 1, Colors.white , Colors.blue),
                    ]),

                    TableRow(children: [
                      buildButton("-", 1, Colors.white , Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.white , Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.blue , Colors.white),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
