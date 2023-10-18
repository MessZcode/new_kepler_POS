import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/payment_viewModel.dart';

class SelectAmountwidget extends StatelessWidget {
  const SelectAmountwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    final paymentSelectOptions = context.watch<PaymentViewModels>().paymentSelectOptions;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screen.height * 0.01),
      child: SizedBox(
        height: screen.height * 0.07,
        child: ListView.builder(
          itemCount: paymentSelectOptions.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screen.height * 0.009),
              child: ElevatedButton(
                onPressed: () {
                  context.read<PaymentViewModels>().onTapSelectAmount(paymentSelectOptions[index]);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.background,
                  side: BorderSide(color: theme.onBackground, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: AutoSizeText(
                  paymentSelectOptions[index].toStringAsFixed(0),
                  style: TextStyle(fontSize: 20, color: theme.onBackground),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
