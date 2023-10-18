import 'package:flutter/material.dart';

import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:kepler_pos/widgets/Dialog/confirm_dialog.dart';
import 'package:kepler_pos/widgets/Dialog/success_dialog.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/membership_viewmodel.dart';
import '../../../ViewModel/navbar_viewmodel.dart';
import '../../../ViewModel/payment_viewModel.dart';

class TitleMenuwidget extends StatefulWidget {
  const TitleMenuwidget({super.key});

  @override
  State<TitleMenuwidget> createState() => _TitleMenuwidgetState();
}

class _TitleMenuwidgetState extends State<TitleMenuwidget> {
  _onclickBack() {
    final billOrder = context.read<PaymentViewModels>().billOrder;
    final billDetail = context.read<PaymentViewModels>().bilLDetail;
    final customer = context.read<PaymentViewModels>().customer;
    context.read<MembershipViewmodel>().setCustomerInHome(customer: customer);
    context.read<HomeViewModels>().setBillOrderAndBillDetail(billOrder: billOrder, billDetail: billDetail);
    context.read<PaymentViewModels>().clearAllinPayment();
    context.read<NavbarViewModels>().updateSelectPage(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            _onclickBack();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.background,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: theme.onPrimary),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: theme.onPrimary,
          ),
          label: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              "Back to order",
              style: TextStyle(
                color: theme.onPrimary,
                fontSize: 24,
                fontFamily: 'Noto Sans Thai',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Confirm_Dialog(
                    text1: 'Are you sure you want to',
                    text2: 'cancel bill?',
                    onTap_yes: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => const Success_Dialog(text: 'Cancel bill success!'),
                      );
                    },
                    onTap_cancels: () {
                      Navigator.pop(context);
                    },
                    color_buttonyes: theme.error,
                    image: 'assets/images/dialogImages/Cancel.png',
                    colorText1: theme.primary,
                    colorText2: theme.primary);
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.background,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: theme.error),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: Icon(
            Icons.delete_forever,
            color: theme.error,
          ),
          label: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              "Cancel Bill",
              style: TextStyle(
                color: theme.error,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
