import 'package:flutter/material.dart';

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
