import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttm/common/ttm_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Scaffold(
        body: Container(
          alignment: const Alignment(0, -0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '畅途慧通',
                style: TextStyle(
                  color: TTMColors.titleColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 20,
              ),
              const Text(
                '一路随行',
                style: TextStyle(
                  color: TTMColors.secondTitleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
