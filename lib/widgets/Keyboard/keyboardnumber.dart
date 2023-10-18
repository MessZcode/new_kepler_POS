import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'keyboard_widget.dart';

//
class Keyboardnumber extends StatefulWidget {
  final Function(String) keyString;
  const Keyboardnumber({Key? key, required this.keyString}) : super(key: key);

  @override
  State<Keyboardnumber> createState() => _KeyboardnumberState();
}

class _KeyboardnumberState extends State<Keyboardnumber> {
  final keys = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    ['0', '<-'],
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: keys
          .map((x) => Expanded(
                child: Row(
                  children: x.map(
                    (y) {
                      return Expanded(
                        flex: y == '0' ? 2 : 1,
                        child: KeyboardWidget(
                          label: y == '<-'
                              ? Image.asset('assets/icons/backspace.png')
                              : AutoSizeText(
                                  y,
                                  minFontSize: 1,
                                  maxFontSize: 22,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: theme.primary,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          buttoncolors: theme.onSecondary,
                          textcolors: Colors.black,
                          onTap: () {
                            widget.keyString(y);
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
              ))
          .toList(),
    );
  }
}
