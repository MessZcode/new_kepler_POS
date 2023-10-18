import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/drawer_viewmodel.dart';
import 'package:kepler_pos/widgets/Dialog/successButton_dialog.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/payment_viewModel.dart';

class paymentcash_dialog extends StatelessWidget {
  const paymentcash_dialog({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final billOrder = context.watch<PaymentViewModels>().billOrder;
    final paymentStatusDetail = context.watch<PaymentViewModels>().paymentStatusDetail;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      actionsPadding:
          EdgeInsets.only(left: screen.height * 0.03, right: screen.height * 0.03, bottom: screen.height * 0.03),
      content: SizedBox(
        width: screen.width * 0.5,
        child: Column(
          children: [
            SizedBox(
              height: screen.height * 0.3,
              child: Image.asset('assets/success1.png'),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pay Amount',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    // homeState.billProduct.first.payAmount.toStringAsFixed(2),
                    billOrder.totalAmount.toStringAsFixed(2),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: theme.onBackground,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cash Tendered',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${context.watch<PaymentViewModels>().paymentStatusDetail.paymentValueAmount}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: theme.onBackground,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order remaining',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    paymentStatusDetail.orderRemaining.toStringAsFixed(2),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: theme.onBackground,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: Container(
                  decoration: ShapeDecoration(
                    color: theme.onError,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Change Amount',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.secondary,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          paymentStatusDetail.changeAmount.toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.secondary,
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  context.read<DrawerViewModels>().paymentcash(
                      double.parse(context.read<PaymentViewModels>().textEditingController.text) -
                          paymentStatusDetail.changeAmount);
                  context.read<PaymentViewModels>().clearAllinPayment();
                  context.read<PaymentViewModels>().textEditingController.clear();

                  Navigator.pop(context);
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const successButtonDialog();
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: ShapeDecoration(
                    color: theme.onBackground,
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
                      color: theme.background,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
