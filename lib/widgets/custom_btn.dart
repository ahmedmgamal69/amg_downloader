// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  Color? btnColor;
  String? btnTxt;
  void Function()? btnAction;

  CustomBtn(
      {super.key,
      required this.btnColor,
      required this.btnTxt,
      required this.btnAction});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: btnColor,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        onPressed: btnAction,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          btnTxt!,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Helvetica"),
        ));
  }
}
