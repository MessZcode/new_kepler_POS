import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class insuccess extends StatelessWidget {
  const insuccess({Key? key, required this.paidType}) : super(key: key);
  final String paidType;
  //
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(children: [
          Image.asset('assets/images/dialogImages/hinsuccess.png'),
          Text(
              '${(paidType.toString() == '1' ? 'Paid in' : (paidType.toString() == '2' ? 'Paid out' : (paidType.toString() == '3' ? 'Expense' : 'NO sale')))} success!',
              style: TextStyle(
                color: theme.onBackground,
                fontSize: 48,
                fontWeight: FontWeight.w700,
              )),
        ]),
      ),
      // Container(
      //   width: screenWidth * 0.5,
      //   height: screenHeight * 0.5,
      //   padding: const EdgeInsets.all(50),
      //   child: Column(
      //     children: [
      //       Expanded(
      //         child: Container(
      //           width: screenWidth * 0.13,
      //           height: screenHeight * 0.25,
      //           decoration: const BoxDecoration(
      //             image: DecorationImage(
      //               image: AssetImage('assets/hinsuccess.png'),
      //               fit: BoxFit.fill,
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: screenHeight * 0.04,
      //       ),
      //       Column(
      //         children: [
      //           Row(
      //             mainAxisSize: MainAxisSize.min,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               AutoSizeText(
      //                 '${(paidType.toString() == '1' ? 'Paid in' : (paidType.toString() == '2' ? 'Paid out' : (paidType.toString() == '3' ? 'Expense' : 'NO sale')))} success!',
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   color: theme.onBackground,
      //                   fontSize: 48,
      //                   fontWeight: FontWeight.w700,
      //                 ),
      //                 minFontSize: 1,
      //                 maxFontSize: 48,
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
