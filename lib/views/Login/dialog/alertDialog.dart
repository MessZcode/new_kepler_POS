import 'package:flutter/material.dart';

class Alertdialoglogin extends StatefulWidget {
  final String text;
  const Alertdialoglogin({super.key, required this.text});
  //
  @override
  State<Alertdialoglogin> createState() => _AlertdialogloginState();
}

class _AlertdialogloginState extends State<Alertdialoglogin> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/confirm.png'),
            Text(widget.text,
                style: const TextStyle(
                  // color: Color(0xFF1CAF82),
                  fontSize: 48,
                  fontFamily: 'Noto Sans Thai',
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
      actions: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text('Close'),
              )),
        )
      ],
    );
  }
}
