import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 48.0,
            color: Colors.black,
          ),
        ),
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String display = '0';
  double num1 = 0;
  double num2 = 0;
  String operator = '';
  bool shouldClear = false;

  void onPressed(String buttonText) {
    if (buttonText == 'C') {
      clearDisplay();
    } else if (buttonText == '=') {
      calculateResult();
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'x' ||
        buttonText == '/') {
      setOperator(buttonText);
    } else if (buttonText == '√') {
      calculateSquareRoot();
    } else if (buttonText == '^') {
      calculateExponent();
    } else {
      updateDisplay(buttonText);
    }
  }

  void clearDisplay() {
    setState(() {
      display = '0';
      num1 = 0;
      num2 = 0;
      operator = '';
      shouldClear = false;
    });
  }

  void updateDisplay(String value) {
    setState(() {
      if (shouldClear) {
        display = value;
        shouldClear = false;
      } else {
        display = display == '0' ? value : display + value;
      }
    });
  }

  void setOperator(String op) {
    setState(() {
      num1 = double.parse(display);
      operator = op;
      shouldClear = true;
    });
  }

  void calculateResult() {
    setState(() {
      num2 = double.parse(display);
      switch (operator) {
        case '+':
          display = (num1 + num2).toString();
          break;
        case '-':
          display = (num1 - num2).toString();
          break;
        case 'x':
          display = (num1 * num2).toString();
          break;
        case '/':
          if (num2 != 0) {
            display = (num1 / num2).toString();
          } else {
            display = 'Error';
          }
          break;
        case '^':
          display = (pow(num1, num2)).toString(); // Calcula el exponente
          break;
      }
      operator = '';
      shouldClear = true;
    });
  }

  void calculateSquareRoot() {
    setState(() {
      num1 = double.parse(display);
      if (num1 >= 0) {
        display = (sqrt(num1)).toString(); // Calcula la raíz cuadrada
      } else {
        display = 'Error';
      }
      operator = '';
      shouldClear = true;
    });
  }

  void calculateExponent() {
    setState(() {
      num2 = double.parse(display);
      display = (pow(num1, num2)).toString(); // Calcula el exponente
      operator = '';
      shouldClear = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Flutter'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Text(
                display,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                final buttonText = [
                  '7',
                  '8',
                  '9',
                  '/',
                  '4',
                  '5',
                  '6',
                  'x',
                  '1',
                  '2',
                  '3',
                  '-',
                  'C',
                  '0',
                  '=',
                  '+',
                  '√',
                  '^',
                ][index];
                return InkWell(
                  onTap: () {
                    onPressed(buttonText);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                );
              },
              itemCount: 18,
            ),
          ),
        ],
      ),
    );
  }
}