import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Payment/dialog/paymentcash_dialog.dart';
import 'package:kepler_pos/views/Payment/widget/selectAmount_widget.dart';
import 'package:kepler_pos/views/Payment/widget/selectTypepay_widget.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/base_viewmodel.dart';
import '../../../ViewModel/drawer_viewmodel.dart';
import '../../../ViewModel/payment_viewModel.dart';
import '../../../widgets/Keyboard/keyboardcash.dart';

class Payamountwidget extends StatefulWidget {
  const Payamountwidget({super.key});

  @override
  State<Payamountwidget> createState() => _PayamountwidgetState();
}

class _PayamountwidgetState extends State<Payamountwidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    final billOrder = context.watch<PaymentViewModels>().billOrder;
    final paymentStatusDetail =
        context.watch<PaymentViewModels>().paymentStatusDetail;
    final paymentOptions = context.watch<PaymentViewModels>().paymentOptions;
    final paymentValue =
        context.watch<PaymentViewModels>().textEditingController;
    void onTapKeyboard(String value) {
      context.read<PaymentViewModels>().onTapKeyboardCash(value);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screen.width * 0.01),
            decoration: ShapeDecoration(
              color: theme.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'payamount',
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AutoSizeText(
                      billOrder.totalAmount.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 26,
                        color: theme.onBackground,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'Order remaining',
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AutoSizeText(
                      paymentStatusDetail.orderRemaining.toStringAsFixed(2),
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.only(top: screen.height * 0.01),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: screen.height * 0.1,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: ShapeDecoration(
                              color: theme.primaryContainer,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: theme.onBackground),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x0C000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 4),
                                  spreadRadius: -2,
                                ),
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 15,
                                  offset: Offset(0, 10),
                                  spreadRadius: -3,
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                    'assets/${paymentOptions.firstWhere((options) => options.id == paymentStatusDetail.paymentId).image}'),
                                SizedBox(
                                  width: screen.width * 0.01,
                                ),
                                Text(
                                  paymentOptions
                                      .firstWhere((options) =>
                                          options.id ==
                                          paymentStatusDetail.paymentId)
                                      .text,
                                  style: TextStyle(
                                    color: theme.onBackground,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screen.height * 0.01,
                                bottom: screen.height * 0.01),
                            child: AutoSizeText('other',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: theme.onPrimary,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          const SelectTypePayment(),
                        ]),
                  ),
                  SizedBox(
                    width: screen.width * 0.01,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                    width: 1, color: theme.onBackground),
                              )),
                              child: Row(
                                children: [
                                  FittedBox(
                                    child: Text(
                                      "Enter\nAmount",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: theme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: context
                                          .watch<PaymentViewModels>()
                                          .textEditingController,
                                      readOnly: true,
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: theme.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "0.00",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: theme.onPrimary,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ), // ปรับตำแหน่งของ hintText ให้พอดี
                                      ),
                                      textAlign: TextAlign
                                          .end, // ตั้งค่าการจัดตำแหน่งของข้อความเป็นขวาสุด
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screen.height * 0.01,
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Change Amount: ',
                                    style: TextStyle(
                                      color: theme.secondary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: paymentStatusDetail.changeAmount
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                      color: theme.secondary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: screen.height * 0.01,
                              ),
                              child: Divider(
                                height: 5,
                                color: theme.onSurface,
                              ),
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: SelectAmountwidget(),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Keyboardcash(
                                    value: (String value) {
                                      onTapKeyboard(value);
                                    },
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(height: screen.height * 0.01),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (paymentValue.text.isNotEmpty &&
                                          double.parse(paymentValue.text) !=
                                              0.0) {
                                        context
                                            .read<PaymentViewModels>()
                                            .onSubmitPayment(
                                                paymentStatusDetail:
                                                    paymentStatusDetail)
                                            .then((value) {
                                          context
                                              .read<BaseViewModel>()
                                              .getOrder();
                                          context
                                              .read<BaseViewModel>()
                                              .getOrderDetail();

                                          print(paymentStatusDetail
                                                  .orderRemaining -
                                              paymentStatusDetail.changeAmount);
                                          if (paymentStatusDetail
                                                  .paymentSuccess ==
                                              true) {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) =>
                                                    const paymentcash_dialog());
                                          } else {
                                            context
                                                .read<DrawerViewModels>()
                                                .paymentcash(double.parse(
                                                    context
                                                        .read<
                                                            PaymentViewModels>()
                                                        .textEditingController
                                                        .text));
                                            context
                                                .read<PaymentViewModels>()
                                                .textEditingController
                                                .clear();
                                          }
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.onBackground,
                                        disabledBackgroundColor: theme
                                            .onBackground
                                            .withOpacity(0.20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 14),
                                      child: Text('Pay',
                                          style: TextStyle(
                                              color: theme.background)),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }
}
