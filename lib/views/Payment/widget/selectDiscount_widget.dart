import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dialog/coupon_dialog.dart';
import '../dialog/discount_dialog.dart';
import '../dialog/note_dialog.dart';

class SelectDiscount extends StatelessWidget {
  const SelectDiscount({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screen = MediaQuery.of(context).size;
    // final paymentviewmodel = Provider.of<Paymentviewmodel>(context);
    return SizedBox(
      width: screen.width * 0.3,
      height: screen.height * 0.07,
      child: ListView.builder(
        itemCount: 1,
        // itemCount: paymentviewmodel.listdiscount.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(screen.height * 0.01),
            child: SizedBox(
              width: screen.width * 0.09,
              child: ElevatedButton(
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     // return paymentviewmodel.listdiscount[index].dialog;
                    //   },
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18), side: BorderSide(color: theme.disabledColor))),
                  child: Row(
                    children: [
                      // Icon(paymentviewmodel.listDiscount[index].icondiscount,
                      //     color: theme.disabledColor),
                      Expanded(
                        child: SizedBox(
                            // child:
                            // AutoSizeText(
                            //   paymentviewmodel.listdiscount[index].text,
                            //   style: TextStyle(color: theme.disabledColor),
                            // ),
                            ),
                      )
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
