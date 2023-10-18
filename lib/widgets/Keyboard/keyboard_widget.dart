import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

//
class KeyboardWidget extends StatefulWidget {
  final Widget label;
  final dynamic value;
  final dynamic buttoncolors;
  final dynamic textcolors;
  final Function() onTap;
  const KeyboardWidget(
      {super.key,
      required this.label,
      this.value,
      required this.onTap,
      required this.buttoncolors,
      required this.textcolors});

  @override
  State<KeyboardWidget> createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screen.width * 0.003, vertical: screen.width * 0.003),
      child: ElevatedButton(
        onPressed: () {
          widget.onTap();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttoncolors,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        child: Center(
          child: widget.label,
        ),
      ),
    );
  }
}
