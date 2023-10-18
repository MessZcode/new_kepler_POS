import 'package:flutter/material.dart';

// import '../../../widgets/Dialog/confirm_dialog.dart';
import '../../../widgets/Keyboard/keyboard.dart';
//
class CouponDialog extends StatelessWidget {
  const CouponDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      actionsPadding: const EdgeInsets.only(bottom: 25, right: 25, left: 25),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Coupon', style: TextStyle(fontSize: 26)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.close))
      ]),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.52,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            padding:
                const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 8),
            decoration: ShapeDecoration(
              color: theme.canvasColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: theme.indicatorColor),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Column(children: [
              Row(
                children: [
                  Text('Enter Coupon Code',
                      style: TextStyle(
                        color: theme.indicatorColor,
                        fontSize: 20,
                        fontFamily: 'Noto Sans Thai',
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Noto Sans Thai',
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: theme.disabledColor,
                decoration: const InputDecoration(
                    hintText: 'Coupon Code',
                    hintStyle: TextStyle(
                      color: Color(0xFFCBD3D6),
                      fontSize: 32,
                      fontFamily: 'Noto Sans Thai',
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none),
              ),
            ]),
          ),
          Expanded(
              child: Container(
            child: Keyboard(
              Bgcolorkeynumber: Color.fromRGBO(188, 193, 212, 1),
              Textcolorkeynumber: Colors.black,
              value: (String value) {},
            ),
          )),
        ]),
      ),
      actions: [
        Container(
          width: MediaQuery.of(context).size.width * 0.32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFEFEFE),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFF7A8C96)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 26,
                          fontFamily: 'Noto Sans Thai',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return const Confirm_Dialog(
                    //       text1: 'Coupon discount : xxxxxxxxxx',
                    //       text2: 'price XX.00฿ from XX.00฿',
                    //     );
                    //   },
                    // );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
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
                    child: const Center(
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'Noto Sans Thai',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
