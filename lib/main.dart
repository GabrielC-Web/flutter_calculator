import 'package:flutter/material.dart';

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
        leading: const Icon(
          Icons.settings,
          color: Colors.orange,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Text('DEG', style: TextStyle(color: Colors.white38)),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: const Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: CalculatorPage()),
    );
  }
}

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          CalculatorButtons(),
        ],
      ),
    );
  }
}

class CalculatorButtons extends StatelessWidget {
  const CalculatorButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              calcButton('C', Colors.grey, () => ('C')),
              calcButton('+/-', Colors.grey, () => ('+/-')),
              calcButton('%', Colors.grey, () => ('%')),
              calcButton('÷', Colors.orange, () => ('÷')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcButton('7', Colors.grey[900]!, () => ('7')),
              calcButton('8', Colors.grey[900]!, () => ('8')),
              calcButton('9', Colors.grey[900]!, () => ('9')),
              calcButton('x', Colors.orange, () => ('x')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcButton('4', Colors.grey[900]!, () => ('AC')),
              calcButton('5', Colors.grey[900]!, () => ()),
              calcButton('6', Colors.grey[900]!, () => ()),
              calcButton('-', Colors.orange, () => ()),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcButton('1', Colors.grey[900]!, () => ()),
              calcButton('2', Colors.grey[900]!, () => ()),
              calcButton('3', Colors.grey[900]!, () => ()),
              calcButton('+', Colors.orange, () => ()),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcButton('0', Colors.grey[900]!, () => ()),
              calcButton(',', Colors.grey[900]!, () => ()),
              calcButton('=', Colors.orange, () => ()),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

Widget calcButton(
    String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Container(
    width: buttonText == '=' ? 165 : 75,
    height: 70,
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: buttonColor,
          minimumSize: const Size(70, 70),
          padding: const EdgeInsets.all(20)),
      // style: ButtonStyle(
      //     backgroundColor: MaterialStateProperty.all<Color>(buttonColor)),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 27, color: Colors.white),
      ),
    ),
  );
}
