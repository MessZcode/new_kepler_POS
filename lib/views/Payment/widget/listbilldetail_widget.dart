import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/payment_viewModel.dart';

class ListBillDetail extends StatefulWidget {
  const ListBillDetail({super.key});

  @override
  State<ListBillDetail> createState() => _ListBillDetailState();
}

class _ListBillDetailState extends State<ListBillDetail> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final billDetail = context.watch<PaymentViewModels>().bilLDetail;
    final showPayment = context.watch<PaymentViewModels>().showPaymentSuccess;
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: billDetail.length + 1,
          itemBuilder: (context, index) {
            if (billDetail.length - index + 1 != 1) {
              return SizedBox(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              '(x${billDetail[index].productQty})',
                              style: TextStyle(
                                fontSize: 18,
                                color: theme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  billDetail[index].productName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: theme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Discount : ${billDetail[index].discount}',
                                  style: TextStyle(
                                    color: theme.onPrimary,
                                    // fontSize: 16,

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Size: S',
                                  style: TextStyle(
                                    color: theme.onPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Color: Blue',
                                  style: TextStyle(
                                    color: theme.onPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              (billDetail[index].subTotal + billDetail[index].discount).toStringAsFixed(2),
                              style: TextStyle(
                                color: theme.onPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              billDetail[index].subTotal.toStringAsFixed(2),
                              style: TextStyle(
                                color: theme.onBackground,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Divider(
                        height: 5,
                        color: theme.onSurface,
                      ),
                    ),
                  ],
                ),
              );
            } else if (showPayment.isNotEmpty) {
              return SizedBox(
                // color: Colors.blue[100],
                height: 150,
                child: ListView.builder(
                  itemCount: showPayment.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(showPayment[index].paymentString,
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                            Text(
                              showPayment[index].paymentValue.toStringAsFixed(2),
                              style: TextStyle(color: theme.onBackground, fontWeight: FontWeight.w700, fontSize: 16),
                            )
                          ],
                        ),
                        Divider(
                          color: theme.onSurface,
                        )
                      ],
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
