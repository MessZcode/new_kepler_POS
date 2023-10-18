import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/payment_viewModel.dart';

class SelectTypePayment extends StatefulWidget {
  const SelectTypePayment({super.key});

  @override
  State<SelectTypePayment> createState() => _SelectTypePaymentState();
}

class _SelectTypePaymentState extends State<SelectTypePayment> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    final ScrollController controllers = ScrollController();
    final paymentOptions = context.watch<PaymentViewModels>().paymentOptions;
    final paymentStatusDetail = context.watch<PaymentViewModels>().paymentStatusDetail;

    return Expanded(
      child: GridView.builder(
        controller: controllers,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2 / 1, crossAxisCount: 2),
        itemCount: paymentOptions.where((options) => options.id != paymentStatusDetail.paymentId).length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              context.read<PaymentViewModels>().updateSelectPaymentId(
                  paymentId: paymentOptions
                      .where((options) => options.id != paymentStatusDetail.paymentId)
                      .toList()[index]
                      .id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                        'assets/${paymentOptions.where((options) => options.id != paymentStatusDetail.paymentId).toList()[index].image}'),
                  ),
                ),
                if (paymentOptions
                        .where((options) => options.id != paymentStatusDetail.paymentId)
                        .toList()[index]
                        .text !=
                    "")
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: screen.width * 0.01,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              paymentOptions
                                  .where((options) => options.id != paymentStatusDetail.paymentId)
                                  .toList()[index]
                                  .text,
                              style: TextStyle(color: theme.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
