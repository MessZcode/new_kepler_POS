import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/home_viewModels.dart';
import 'keyboardScreen.dart';
import 'keyboard_widget.dart';

//
class Keyboard extends StatefulWidget {
  final Function(String) value;
  // final String Bgcolorkeytext;
  final dynamic Bgcolorkeynumber;
  final dynamic Textcolorkeynumber;
  const Keyboard({super.key, required this.value, required this.Bgcolorkeynumber, required this.Textcolorkeynumber});

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  final keystext = [
    ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '<-'],
    ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'enter'],
    ['z', 'x', 'c', 'v', 'b', 'n', 'm', '<', '>'],
    ['shift1', 'space', 'shift2'],
  ];

  final keysnumber = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    ['0', '.'],
  ];
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final home = Provider.of<HomeViewModels>(context);

    Widget sizebox() {
      return SizedBox(
        width: screen.width * 0.01,
      );
    }

    Widget icondelete() {
      return Image.asset(
        'assets/icons/backspace.png',
        color: theme.error,
      );
    }

    Widget iconarrowup() {
      return Image.asset(
        'assets/icons/arrow-big-up.png',
        color: theme.primary,
      );
    }

    Widget iconarrowleft() {
      return Expanded(
          child: Image.asset(
        'assets/icons/corner-down-left.png',
        color: theme.primary,
      ));
    }

    Widget Textlabel(String value) {
      return AutoSizeText(
        value,
        minFontSize: 1,
        maxFontSize: 22,
        maxLines: 1,
        style: TextStyle(
          color: theme.primary,
          fontSize: 36,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Column(
              children: keystext
                  .map((x) => Expanded(
                        child: Row(
                          children: x.map(
                            (y) {
                              return Expanded(
                                flex: y == 'enter' || y == '<' || y == '>' || y == 'space' ? 2 : 1,
                                child: KeyboardScreen(
                                    label: y == 'enter'
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [Textlabel(y.toUpperCase()), sizebox(), iconarrowleft()],
                                          )
                                        : y == '<-'
                                            ? icondelete()
                                            : y == 'shift1'
                                                ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      iconarrowup(),
                                                      sizebox(),
                                                      Textlabel('shift'.toUpperCase())
                                                    ],
                                                  )
                                                : y == 'shift2'
                                                    ? Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Textlabel('shift'.toUpperCase()),
                                                          sizebox(),
                                                          iconarrowup()
                                                        ],
                                                      )
                                                    : Textlabel(y.toUpperCase()),
                                    onTap: () {
                                      widget.value(y);
                                    },
                                    buttoncolors: theme.onError,
                                    textcolors: theme.primary),
                              );
                            },
                          ).toList(),
                        ),
                      ))
                  .toList(),
            )),
        Expanded(
            flex: 1,
            child: Column(
                children: keysnumber
                    .map((x) => Expanded(
                          child: Row(
                            children: x.map(
                              (y) {
                                return Expanded(
                                    flex: y == '0' ? 2 : 1,
                                    child: KeyboardScreen(
                                      label: AutoSizeText(
                                        y,
                                        minFontSize: 1,
                                        maxFontSize: 22,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: theme.background,
                                          fontSize: 36,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      onTap: () {
                                        widget.value(y);
                                      },
                                      buttoncolors: widget.Bgcolorkeynumber,
                                      textcolors: widget.Textcolorkeynumber,
                                    ));
                              },
                            ).toList(),
                          ),
                        ))
                    .toList())),
      ],
    );
  }
}
