import 'package:flutter/material.dart';
import 'package:kepler_pos/widgets/Dialog/success_dialog.dart';
//
// import '../../../widgets/Keyboard/keyboardnumber.dart';
//
class Discountdialog extends StatefulWidget {
  const Discountdialog({super.key});

  @override
  State<Discountdialog> createState() => _DiscountdialogState();
}

class _DiscountdialogState extends State<Discountdialog> {
  Widget button_selectnumber(String number) {
    final theme = Theme.of(context);
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: ShapeDecoration(
        color: theme.cardColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: theme.indicatorColor),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: -1,
          )
        ],
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            color: theme.indicatorColor,
            fontSize: 20,
            fontFamily: 'Noto Sans Thai',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      actionsPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      contentPadding: EdgeInsets.all(24),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Discount',
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'Noto Sans Thai',
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close),
            color: theme.disabledColor,
          )
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 26,
                fontFamily: 'Noto Sans Thai',
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                  suffixText: '%',
                  hintText: '0',
                  hintStyle: const TextStyle(
                    color: Color(0xFFCBD3D6),
                    fontSize: 26,
                    fontFamily: 'Noto Sans Thai',
                    fontWeight: FontWeight.w700,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: theme.indicatorColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: theme.indicatorColor),
                      borderRadius: BorderRadius.circular(16))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: [
                  button_selectnumber('5%'),
                  const SizedBox(
                    width: 10,
                  ),
                  button_selectnumber('10%'),
                  const SizedBox(
                    width: 10,
                  ),
                  button_selectnumber('20%'),
                  const SizedBox(
                    width: 10,
                  ),
                  button_selectnumber('30%'),
                ],
              ),
            ),
            Expanded(
                child: Container(
              // color: Colors.pink[200],
              // child: const Keyboardnumber(),
            ))
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFEFEFE),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF7A8C96)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF252525),
                      fontSize: 28,
                      fontFamily: 'Noto Sans Thai',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) {
                    return Success_Dialog(
                      text: 'Add discount success!',
                    );
                  },
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: ShapeDecoration(
                  color: theme.indicatorColor,
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
                    'OK',
                    style: TextStyle(
                      color: theme.canvasColor,
                      fontSize: 28,
                      fontFamily: 'Noto Sans Thai',
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
