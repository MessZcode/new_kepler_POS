import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/models/main_model.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:kepler_pos/widgets/Dialog/confirm_dialog.dart';
import 'package:kepler_pos/widgets/Dialog/success_dialog.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/base_viewmodel.dart';
import '../../ViewModel/membership_viewmodel.dart';
import '../../ViewModel/navbar_viewmodel.dart';
import '../../ViewModel/payment_viewModel.dart';

class TotalPayment extends StatefulWidget {
  const TotalPayment({
    super.key,
  });

  @override
  State<TotalPayment> createState() => _TotalPaymentState();
}

class _TotalPaymentState extends State<TotalPayment> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final billAmount = context.watch<HomeViewModels>().billOrder;

    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            side: BorderSide(color: theme.background, width: 4)),
        color: theme.onError,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRow(
                      content: (billAmount.totalAmount + billAmount.discountAmount).toString(),
                      header: 'Total',
                      color: theme.primary),
                  _buildRow(
                      content: billAmount.discountAmount.toString(), header: 'Item Discount', color: theme.primary),
                  _buildRow(content: billAmount.vatAmount.toStringAsFixed(2), header: 'VAT 7%', color: theme.primary),
                  _buildRow(content: billAmount.totalAmount.toString(), header: 'Pay Amount', color: theme.primary),
                ],
              ),
            ),
          ),
          _buildBtn(context: context),
        ],
      ),
    );
  }

  Widget _buildRow({required String header, required String content, required Color color}) {
    return Row(
      children: [
        Text(
          header,
          style: TextStyle(fontSize: header == "Pay Amount" ? 24 : 18, color: color, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        Text(content,
            style: TextStyle(fontSize: header == "Pay Amount" ? 24 : 18, color: color, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildBtn({required BuildContext context}) {
    final theme = Theme.of(context).colorScheme;
    final billOrder = context.watch<HomeViewModels>().billOrder;
    final billDetail = context.watch<HomeViewModels>().billDetail;
    final customer = context.watch<MembershipViewmodel>().customer;
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: theme.onPrimary, width: 1)),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => _onHoldButtonPressed(context),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(theme.background),
                fixedSize: MaterialStateProperty.all(
                  const Size(double.infinity, 78),
                ),
                side: MaterialStateProperty.all(
                  BorderSide(color: theme.onBackground),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ), // Set the desired border radius here
                  ),
                ),
              ),
              child: AutoSizeText(
                "Hold",
                maxLines: 1,
                maxFontSize: 30,
                minFontSize: 1,
                overflowReplacement: const ClipRRect(),
                style: TextStyle(
                  color: theme.onBackground,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme.onBackground),
                fixedSize: MaterialStateProperty.all(const Size(double.infinity, 78)),
                side: MaterialStateProperty.all(BorderSide(color: theme.onBackground)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ), // Set the desired border radius here
                  ),
                ),
              ),
              onPressed: () {
                _paymentButtonPressed(billOrder: billOrder, billDetail: billDetail, customer: customer);
              },
              child: AutoSizeText(
                "Payment",
                maxLines: 1,
                maxFontSize: 30,
                minFontSize: 1,
                overflowReplacement: const ClipRRect(),
                style: TextStyle(
                  color: theme.background,
                  fontSize: 30,
                  fontFamily: 'Noto Sans Thai',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onHoldButtonPressed(BuildContext context) async {
    final theme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => Confirm_Dialog(
          text1: "Are you sure you want to",
          text2: "hold bill?",
          onTap_yes: () async {
            try {
              final homeViewModel = context.read<HomeViewModels>();
              final baseViewModel = context.read<BaseViewModel>();
              final membershipViewModel = context.read<MembershipViewmodel>();

              await homeViewModel.onPressedHold(
                billDetail: homeViewModel.billDetail,
                billOrders: homeViewModel.billOrder,
              );

              await baseViewModel.getOrder();
              await baseViewModel.getOrderDetail();
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) => const Success_Dialog(text: "Hold bill success!"),
              );

              homeViewModel.clearBill();
              membershipViewModel.clearCustomer();
            } catch (error) {
              print('Error: $error');
            }
          },
          onTap_cancels: () {
            Navigator.pop(context);
          },
          color_buttonyes: theme.onBackground,
          image: 'assets/images/dialogImages/confirm.png',
          colorText1: theme.primary,
          colorText2: theme.primary),
    );
  }

  //TODO Click Payment in HomePages
  Future<void> _paymentButtonPressed(
      {required BillOrderModels billOrder,
      required List<BillDetailModel> billDetail,
      required CustomerModels customer}) async {
    billOrder.billStatus = "Payment";
    int orderIdGet =
        await context.read<HomeViewModels>().onPressedPayment(billOrder: billOrder, billDetail: billDetail);
    billOrder.orderId = orderIdGet;
    context.read<PaymentViewModels>().filterPayment(
          billOrder: billOrder,
          billDetail: billDetail,
          customer: customer,
        );
    await context.read<BaseViewModel>().getOrder();
    await context.read<BaseViewModel>().getOrderDetail();
    debugPrint("$orderIdGet");

    context.read<NavbarViewModels>().updateSelectPage(5);
  }
}
