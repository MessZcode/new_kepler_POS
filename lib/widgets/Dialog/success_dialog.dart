import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

//
class Success_Dialog extends StatefulWidget {
  final String text;
  const Success_Dialog({super.key, required this.text});

  @override
  State<Success_Dialog> createState() => _Success_DialogState();
}

class _Success_DialogState extends State<Success_Dialog> {
  bool status = false;
  @override
  void initState() {
    super.initState();
    _loading();
  }

  _loading() async {
    setState(() {
      status = true;
    });
    Timer(const Duration(seconds: 0), () {
      setState(() {
        status = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      contentPadding: const EdgeInsets.all(20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (status)
              SizedBox(
                width: 50.0,
                height: 50.0,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineSpinFadeLoader,
                  colors: [theme.onBackground],
                ),
              ),
            if (!status) Image.asset('assets/images/dialogImages/hinsuccess.png'),
            if (status)
              Text(
                "Loading...",
                style: TextStyle(
                  color: theme.onBackground,
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (!status)
              Text(widget.text,
                  style: TextStyle(
                    color: theme.onBackground,
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  )),
          ],
        ),
      ),
    );
  }
}
