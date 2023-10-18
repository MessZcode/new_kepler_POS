import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ListTotalwidget extends StatelessWidget {
  final String text1;
  final String text2;
  final double fontsize;
  const ListTotalwidget({
    super.key,
    required this.text1,
    required this.text2,
    required this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: AutoSizeText(
            text1,
            maxFontSize: 18,
            minFontSize: 1,
            style: TextStyle(
              fontSize: fontsize,
              fontFamily: 'Noto Sans Thai',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          child: AutoSizeText(
            text2,
            maxFontSize: 18,
            minFontSize: 1,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: fontsize,
              fontFamily: 'Noto Sans Thai',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
