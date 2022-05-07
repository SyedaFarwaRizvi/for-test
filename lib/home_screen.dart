// ignore_for_file: avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);
  List<dynamic> userQuestion = [];
  List<dynamic> userAnswer = [];

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '*',
    '-',
    '+',
    '.',
    'ANS',
    '=',
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2',
    '1',
    '0',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Calculator",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          backgroundColor: Colors.indigo[200],
          foregroundColor: Colors.black,
        ),
        backgroundColor: HexColor("#d4bce3"),
        body: Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 50),
                  Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion[0],
                        style: const TextStyle(fontSize: 20),
                      )),
                  Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(userAnswer[0],
                          style: const TextStyle(fontSize: 20))),
                ],
              ),
            )),
            Expanded(
                flex: 2,
                child: Expanded(
                  child: Container(
                      child: GridView.builder(
                          itemCount: buttons.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                          itemBuilder: (BuildContext context, int index) {
                            //clear button
                            if (index == 0) {
                              return MyButtons(
                                buttonTapped: () {
                                  setState(() {
                                    //userQuestion = '';
                                    userQuestion.clear();
                                  });
                                },
                                buttonText: buttons[index],
                                color: Colors.green,
                                textColor: Colors.white,
                              );
                              //delete button
                            } else if (index == 1) {
                              return MyButtons(
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion = userQuestion[0]
                                        .substring(0, userQuestion.length - 1);
                                  });
                                },
                                buttonText: buttons[index],
                                color: Colors.red,
                                textColor: Colors.white,
                              );
                            }
                            //Equal button
                            else if (index == 9) {
                              return MyButtons(
                                buttonTapped: () {
                                  setState(() {
                                    equalPressed();
                                  });
                                },
                                buttonText: buttons[index],
                                color: Colors.pink,
                                textColor: Colors.white,
                              );
                            }

                            //Rest of buttons
                            else {
                              return MyButtons(
                                buttonTapped: () {
                                  setState(() {
                                    //userQuestion = userQuestion + buttons[index]
                                    userQuestion[0] += buttons[index];
                                  });
                                },
                                buttonText: buttons[index],
                                color: isOperator(buttons[index])
                                    ? Colors.deepPurple
                                    : Colors.deepPurple,
                                textColor: isOperator(buttons[index])
                                    ? Colors.white
                                    : Colors.white,
                              );
                            }
                          })),
                ))
          ],
        ),
      ),
    );
  }
}

bool isOperator(String x) {
  if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
    return true;
  }
  return false;
}

void equalPressed() {
  var question = '';
  String finalQuestion = question;
  Parser p = Parser();
  Expression exp = p.parse(finalQuestion);
  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);
}

class MyButtons extends StatelessWidget {
  dynamic color;
  dynamic textColor;
  dynamic buttonText;
  dynamic buttonTapped;

  MyButtons(
      {Key? key,
      this.color,
      required this.buttonText,
      this.textColor,
      this.buttonTapped})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
    );
  }
}
