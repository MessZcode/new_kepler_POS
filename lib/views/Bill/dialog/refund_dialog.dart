import 'package:flutter/material.dart';
import 'package:kepler_pos/widgets/Dialog/success_dialog.dart';

import '../../../widgets/Keyboard/keyboardcash.dart';

//
class RefundDialog extends StatelessWidget {
  const RefundDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      contentPadding: EdgeInsets.only(
        bottom: 5,
        top: screen.height * 0.02,
        right: screen.width * 0.02,
        left: screen.width * 0.02,
      ),
      actionsPadding: EdgeInsets.only(
        left: screen.width * 0.02,
        right: screen.width * 0.02,
        bottom: screen.height * 0.05,
        top: screen.height * 0.01,
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Refund', style: TextStyle(color: theme.primary)),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: theme.onPrimary,
            ))
      ]),
      content: SizedBox(
        width: screen.width * 0.32,
        height: screen.height * 0.65,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                      prefixText: 'Enter Refund',
                      prefixStyle: TextStyle(color: theme.primary),
                      hintText: '0.00',
                      hintStyle: TextStyle(color: theme.onPrimary),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.onError), borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: theme.onPrimary)))),
            ),
            Expanded(
              child: SizedBox(
                  child: Keyboardcash(
                value: (String value) {},
              )),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(screen.height * 0.07),
                      backgroundColor: theme.background,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), side: BorderSide(color: theme.onPrimary))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: theme.primary),
                  )),
            ),
            SizedBox(width: screen.width * 0.01),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(screen.height * 0.07),
                      backgroundColor: theme.onBackground,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Success_Dialog(text: 'Refund success!');
                      },
                    );
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: theme.background),
                  )),
            ),
          ],
        )
      ],
    );
  }
}
