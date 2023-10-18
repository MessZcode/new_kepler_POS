import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'keyboard_widget.dart';

//
class Keyboardcash extends StatefulWidget {
  final Function(String) value;
  const Keyboardcash({
    super.key,
    required this.value,
  });

  @override
  State<Keyboardcash> createState() => _KeyboardcashState();
}

class _KeyboardcashState extends State<Keyboardcash> {
  final keys = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    ['.', '0', '00'],
  ];
  final keyscontrol = ['<-', 'C'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: keys
                  .map(
                    (x) => Expanded(
                      child: Row(
                          children: x.map(
                        (y) {
                          return Expanded(
                            child: KeyboardWidget(
                              label: AutoSizeText(
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
                              buttoncolors: theme.onError,
                              textcolors: theme.primary,
                              onTap: () {
                                widget.value(y);
                              },
                            ),
                          );
                        },
                      ).toList()),
                    ),
                  )
                  .toList(),
            )),
        Expanded(
            flex: 1,
            child: Column(
                children: keyscontrol.map(
              (x) {
                return Expanded(
                  child: KeyboardWidget(
                    label: x == '<-'
                        ? Image.asset('assets/icons/backspace.png')
                        : AutoSizeText(
                            x,
                            minFontSize: 1,
                            maxFontSize: 22,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.primary,
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    buttoncolors: theme.onError,
                    textcolors: theme.primary,
                    onTap: () {
                      widget.value(x);
                    },
                  ),
                );
              },
            ).toList())),
      ],
    );
  }
}
