import 'package:flutter/material.dart';

import 'package:kepler_pos/views/Payment/widget/membership_payment.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/payment_viewModel.dart';
import 'listTotal_widget.dart';
import 'listbilldetail_widget.dart';

class SummaryPayment extends StatelessWidget {
  const SummaryPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    final billOrder = context.watch<PaymentViewModels>().billOrder;
    return Container(
      decoration: ShapeDecoration(
        color: theme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
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
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'summary',
                        style: TextStyle(
                          color: theme.primary,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const MembershipPayment(),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: Divider(
                height: 5,
                color: theme.onSurface,
              ),
            ),
            const Expanded(child: ListBillDetail()),
            SizedBox(
              height: screen.height * 0.25,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            side: BorderSide(color: theme.background, width: 4)),
                        color: theme.onError,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTotalwidget(
                            text1: 'Total',
                            text2: (billOrder!.totalAmount + billOrder.discountAmount).toStringAsFixed(2),
                            fontsize: 18,
                          ),
                          ListTotalwidget(
                            text1: 'Item Discount',
                            text2: billOrder.discountAmount.toStringAsFixed(2),
                            fontsize: 18,
                          ),
                          ListTotalwidget(
                            text1: 'VAT 7%',
                            text2: billOrder.vatAmount.toStringAsFixed(2),
                            fontsize: 18,
                          ),
                          ListTotalwidget(
                            text1: 'Pay Amount',
                            text2: billOrder.totalAmount.toStringAsFixed(2),
                            fontsize: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
