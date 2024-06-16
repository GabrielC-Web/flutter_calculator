import 'package:flutter/material.dart';
import 'package:flutter_calculator/calc_button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => CalculatorState();
}

class CalculatorState extends State<MyHomePage> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    // ignore: unused_element
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }

      return result;
    }

    setState(() {
      switch (buttonText) {
        case 'C':
          equation = '0';
          result = '0';
          break;
        case '⌫':
          equation = equation.substring(0, equation.length - 1);
          if (equation == "") {
            equation = "0";
          }
        case '+/-':
          if (equation[0] != '-') {
            equation = '-$equation';
          } else {
            equation = equation.substring(1);
          }
        case '=':
          if (equation[equation.length - 1] == 'x' ||
              equation[equation.length - 1] == '÷' ||
              equation[equation.length - 1] == '%' ||
              equation[equation.length - 1] == '-' ||
              equation[equation.length - 1] == '+') {
            //* Muestro el error
            errorSnackBar('¡Formato inválido!');
            return;
          }

          expression = equation;
          expression = expression.replaceAll('x', '*');
          expression = expression.replaceAll('÷', '/');
          expression = expression.replaceAll('%', '%');

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
            if (expression.contains('%')) {
              result = doesContainDecimal(result);
            }
          } catch (e) {
            result = "Error";
          }
        default:
          final String currentLastValue = equation[equation.length - 1];
          final String newLastValue = buttonText;

          //* Veo si hay más de un elemento
          if (equation.length >= 2) {
            //* Veo si es un operador
            if ((currentLastValue == 'x' ||
                    currentLastValue == '÷' ||
                    currentLastValue == '%' ||
                    currentLastValue == '-' ||
                    currentLastValue == '+') &&
                (newLastValue == 'x' ||
                    newLastValue == '÷' ||
                    newLastValue == '%' ||
                    newLastValue == '-' ||
                    newLastValue == '+')) {
              //* Muestro el error
              errorSnackBar('¡Formato inválido!');
              return;
            }
          }

          if (equation == "0") {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
      }
    });
  }

  //* Abre el snackbar de error
  errorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 500),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      content: Text(message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      padding: const EdgeInsets.all(8.0),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black12,
          // leading: const Icon(
          //   Icons.settings,
          //   color: Colors.orange,
          // ),
          // actions: const [
          //   Padding(
          //     padding: EdgeInsets.only(top: 18.0),
          //     child: Text('DEG', style: TextStyle(color: Colors.white38)),
          //   ),
          //   SizedBox(width: 20),
          // ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: RawScrollbar(
                  radius: const Radius.circular(10),
                  thumbVisibility: result.length > 7,
                  trackVisibility: result.length > 7,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(result,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            result.length > 7 ? 60 : 40))),
                            // const Icon(Icons.more_vert,
                            //     color: Colors.orange, size: 30),
                            const SizedBox(width: 20),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(equation,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Colors.white38,
                                  )),
                            ),
                            IconButton(
                              icon: const Icon(Icons.backspace_outlined,
                                  color: Colors.orange, size: 30),
                              onPressed: () {
                                buttonPressed("⌫");
                              },
                            ),
                            const SizedBox(width: 20),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        calcButton('C', Colors.grey, () => buttonPressed('C')),
                        calcButton(
                            '+/-', Colors.grey, () => buttonPressed('+/-')),
                        calcButton('%', Colors.grey, () => buttonPressed('%')),
                        calcButton(
                            '÷', Colors.orange, () => buttonPressed('÷')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calcButton(
                            '7', Colors.grey[900]!, () => buttonPressed('7')),
                        calcButton(
                            '8', Colors.grey[900]!, () => buttonPressed('8')),
                        calcButton(
                            '9', Colors.grey[900]!, () => buttonPressed('9')),
                        calcButton(
                            'x', Colors.orange, () => buttonPressed('x')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calcButton(
                            '4', Colors.grey[900]!, () => buttonPressed('4')),
                        calcButton(
                            '5', Colors.grey[900]!, () => buttonPressed('5')),
                        calcButton(
                            '6', Colors.grey[900]!, () => buttonPressed('6')),
                        calcButton(
                            '-', Colors.orange, () => buttonPressed('-')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calcButton(
                            '1', Colors.grey[900]!, () => buttonPressed('1')),
                        calcButton(
                            '2', Colors.grey[900]!, () => buttonPressed('2')),
                        calcButton(
                            '3', Colors.grey[900]!, () => buttonPressed('3')),
                        calcButton(
                            '+', Colors.orange, () => buttonPressed('+')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calcButton(
                            '0', Colors.grey[900]!, () => buttonPressed('0')),
                        calcButton(
                            '.', Colors.grey[900]!, () => buttonPressed('.')),
                        calcButton(
                            '=', Colors.orange, () => buttonPressed('=')),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
