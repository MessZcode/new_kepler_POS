import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class KeyboardScreen extends StatefulWidget {
  final Widget label;
  final dynamic buttoncolors;
  final dynamic textcolors;
  final Function() onTap;

  const KeyboardScreen({super.key, required this.label, this.buttoncolors, this.textcolors, required this.onTap});

  @override
  State<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

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
