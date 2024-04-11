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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorButtons(),
      ],
    );
  }
}

class CalculatorButtons extends StatelessWidget {
  const CalculatorButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                calcButton('C', Colors.orange, null),
                calcButton('+/-', Colors.white, null),
                calcButton('%', Colors.white, null),
                calcButton('÷', Colors.white, null),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                calcButton('7', Colors.white, null),
                calcButton('8', Colors.white, null),
                calcButton('9', Colors.white, null),
                calcButton('x', Colors.white, null),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                calcButton('4', Colors.white, null),
                calcButton('5', Colors.white, null),
                calcButton('6', Colors.white, null),
                calcButton('-', Colors.white, null),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                calcButton('1', Colors.white, null),
                calcButton('2', Colors.white, null),
                calcButton('3', Colors.white, null),
                calcButton('+', Colors.white, null),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                calcButton('0', Colors.white, null),
                calcButton(',', Colors.white, null),
                calcButton('=', Colors.white, null),
              ],
            ),
          ],
        )
      ],
    );
  }
}

Widget calcButton(
    String buttonText, Color buttonColor, void Function()? buttonPressed) {
  // return Container(
  //   width: buttonText == '=' ? 150 : 75,
  //   height: 70,
  //   padding: const EdgeInsets.all(0),
  //   child: ElevatedButton(
  //     onPressed: buttonPressed,
  //     style: ElevatedButton.styleFrom(
  //         shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(20))),
  //         backgroundColor: Colors.red,
  //         minimumSize: const Size(70, 70),
  //         padding: const EdgeInsets.all(20)),
  //     // style: ButtonStyle(
  //     //     backgroundColor: MaterialStateProperty.all<Color>(buttonColor)),
  //     child: Text(
  //       buttonText,
  //       style: const TextStyle(fontSize: 27, color: Colors.white),
  //     ),
  //   ),
  // );
  return ElevatedButton(
    onPressed: buttonPressed,
    style: ElevatedButton.styleFrom(
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(20))),
        backgroundColor: Colors.red,
        padding: const EdgeInsets.all(20)),
    // style: ButtonStyle(
    //     backgroundColor: MaterialStateProperty.all<Color>(buttonColor)),
    child: Text(
      buttonText,
      style: const TextStyle(fontSize: 27, color: Colors.white),
    ),
  );
}
