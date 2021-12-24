import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_icons.dart';

class FlushBarWidget {
  static createSimple(String str, BuildContext context) {
    Flushbar(
      icon: commonWarning(size: 20, color: TTMColors.white),
      messageText: Text(
        str,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(50),
      backgroundColor: Colors.black,
      boxShadows: const [
        BoxShadow(
            color: Colors.black,
            offset: Offset(2.0, 4.0),
            blurRadius: 20.0,
            spreadRadius: -10)
      ],
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static createDanger(String str, BuildContext context) {
    Flushbar(
      icon: commonError1(size: 20, color: TTMColors.white),
      messageText: Text(
        str,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(50),
      backgroundColor: Colors.redAccent,
      boxShadows: const [
        BoxShadow(
            color: Colors.redAccent,
            offset: Offset(2.0, 4.0),
            blurRadius: 20.0,
            spreadRadius: -10)
      ],
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static createWarning(String str, BuildContext context) {
    Flushbar(
      icon: commonWarning1(size: 20, color: TTMColors.white),
      messageText: Text(
        str,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(50),
      backgroundColor: Colors.orangeAccent,
      boxShadows: const [
        BoxShadow(
            color: Colors.orangeAccent,
            offset: Offset(2.0, 4.0),
            blurRadius: 20.0,
            spreadRadius: -10)
      ],
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static createDone(String str, BuildContext context) {
    Flushbar(
      icon: commonFinish1(size: 20, color: TTMColors.white),
      messageText: Text(
        str,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(50),
      backgroundColor: Colors.green,
      boxShadows: const [
        BoxShadow(
            color: Colors.green,
            offset: Offset(2.0, 4.0),
            blurRadius: 20.0,
            spreadRadius: -10)
      ],
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  static createAbout(BuildContext context) {
    Flushbar(
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
      message: "Version: 1.0",
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(10),
      boxShadows: const [
        BoxShadow(
            color: Colors.black,
            offset: Offset(2.0, 4.0),
            blurRadius: 20.0,
            spreadRadius: -10)
      ],
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);
  }

  static createNetworkNotContected(BuildContext context) {
    Flushbar(
      icon: commonError1(size: 20, color: TTMColors.white),
      messageText: const Text(
        "网络未连接，请检查网络后重试",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(50),
      backgroundColor: Colors.redAccent,
      boxShadows: const [
        BoxShadow(
            color: Colors.redAccent,
            offset: Offset(2.0, 4.0),
            blurRadius: 20.0,
            spreadRadius: -10)
      ],
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
