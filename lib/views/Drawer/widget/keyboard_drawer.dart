import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../models/drawer_model.dart';

//
class Keyboard extends StatefulWidget {
  const Keyboard({
    super.key,
    required this.callbackB,
  });
  final Function(String) callbackB;
  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  int textindex = 0;
  void initState() {
    super.initState();
    lstReason.add(ReasonTender(1, 'Test', 0));
    lstReason.add(ReasonTender(2, 'No Reason', 0));
  }

  void updateValueFromKeyboard(value) {
    updateTotalValues();
  }

  void updateTotalValues() {
    dblTotalValues = 0;

    for (int i = 0; i < lstTender.length; i++) {
      if (textindex == i) {
        int? dblUserInput = 0;
        dblUserInput = int.tryParse(textEditeController[textindex].text);
        dblUserInput = int.tryParse(textEditingController.text);

        dblUserInput ??= 0;

        lstTender[i].userInputQty = dblUserInput;

        lstTender[i].calculatedTotalValue = dblUserInput * lstTender[i].TenderValue.toDouble();
        //textResultController[i].text =            (dblUserInput * lstTender[i].TenderValue).toString();
      }

      //total calculate
      dblTotalValues += lstTender[i].calculatedTotalValue;
    }
  }

  double dblTotalValues = 0;
  List<TextEditingController> textEditeController = [];
  TextEditingController textEditingController = TextEditingController();

  ReasonTender? selectedReason;
  String currentValue = '0';

  String expression = "";
  final List<Tender> lstTender = [];
  Tender t1000 = Tender(1000, '1,000 B', 4, 4000);
  Tender t500 = Tender(500, '500 B', 0, 0);
  Tender t100 = Tender(100, '100 B', 0, 0);
  Tender t50 = Tender(50, '50 B', 0, 0);
  Tender t20 = Tender(20, '20 B', 0, 0);
  Tender t10 = Tender(10, '10 B', 0, 0);
  Tender t5 = Tender(5, '5 B', 0, 0);

  final List<ReasonTender> lstReason = [];

  buttonPressed(String value) {
    // print(value);
    setState(() {
      widget.callbackB(value);
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    // print(textindex);
  }

  Widget myButton(String buttonLabel) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screen.width * 0.003, vertical: screen.width * 0.003),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              buttonPressed(buttonLabel);
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: theme.onError, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          child: Center(
            child: Text(buttonLabel),
          ),
        ),
      ),
    );

    //   Expanded(
    //   child: OutlinedButton(
    //     onPressed: () {
    //       // _textFormFieldFocus.requestFocus();
    //       setState(() {
    //         buttonPressed(buttonLabel);
    //       });
    //     },
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Container(
    //           width: MediaQuery.of(context).size.width * 0.08,
    //           height: MediaQuery.of(context).size.height * 0.05,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               AutoSizeText(
    //                 buttonLabel,
    //                 textAlign: TextAlign.center,
    //                 style: const TextStyle(
    //                   color: Color(0xFF252525),
    //                   fontSize: 32,
    //                   fontFamily: 'Noto Sans Thai',
    //                   fontWeight: FontWeight.w500,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screen.width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  myButton("7"),
                  myButton("4"),
                  myButton("1"),
                  myButton("."),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  myButton("8"),
                  myButton("5"),
                  myButton("2"),
                  myButton("0"),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  myButton("9"),
                  myButton("6"),
                  myButton("3"),
                  myButton("0.00"),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  myButton("⌫"),
                  myButton("C"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
