import 'package:flutter/material.dart';
import 'package:kepler_pos/widgets/Dialog/success_dialog.dart';

//
class Confirm_Dialog extends StatefulWidget {
  final String text1;
  final String text2;
  final Color colorText1;
  final Color colorText2;
  final Function() onTap_yes;
  final Function() onTap_cancels;
  final Color color_buttonyes;
  final String image;

  const Confirm_Dialog({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap_yes,
    required this.onTap_cancels,
    required this.color_buttonyes,
    required this.image,
    required this.colorText1,
    required this.colorText2,
  });

  @override
  State<Confirm_Dialog> createState() => _Confirm_DialogState();
}

class _Confirm_DialogState extends State<Confirm_Dialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      contentPadding: const EdgeInsets.all(30),
      actionsPadding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            Expanded(child: Image.asset(widget.image)),
            Text(
              widget.text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.colorText1,
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.colorText2,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    widget.onTap_cancels();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: ShapeDecoration(
                      color: theme.background,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: theme.onPrimary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'No',
                        style: TextStyle(
                          color: theme.primary,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    widget.onTap_yes();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: ShapeDecoration(
                      // Select color
                      color: widget.color_buttonyes,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 10,
                          offset: Offset(0, 10),
                          spreadRadius: -5,
                        ),
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 25,
                          offset: Offset(0, 20),
                          spreadRadius: -5,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: theme.background,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        )
      ],
    );
  }
}
