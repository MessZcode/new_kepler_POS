import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/payment_viewModel.dart';

class MembershipPayment extends StatefulWidget {
  const MembershipPayment({
    super.key,
  });

  @override
  State<MembershipPayment> createState() => _MembershipPaymentState();
}

class _MembershipPaymentState extends State<MembershipPayment> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final customer = context.watch<PaymentViewModels>().customer;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.primaryContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Image(
                  image: const AssetImage("assets/id.png"),
                  color: theme.onBackground,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      customer!.customerId == 0 ? "MemberShip" : "K. ${customer.fname}",
                      style: TextStyle(
                        color: theme.onBackground,
                        fontSize: 20,
                        fontFamily: 'Noto Sans Thai',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
