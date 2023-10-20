import 'package:flutter/material.dart';

class RowtText extends StatefulWidget {
  final String title;
  final double value;
  const RowtText({super.key, required this.title, required this.value});

  @override
  State<RowtText> createState() => _RowtTextState();
}

class _RowtTextState extends State<RowtText> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screen.width * 0.02, vertical: screen.height * 0.01),
      child: Container(
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            Text('${widget.value.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
