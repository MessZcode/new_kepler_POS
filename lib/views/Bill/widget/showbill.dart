import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/models/main_model.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';

import 'package:kepler_pos/widgets/Dialog/confirm_dialog.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/base_viewmodel.dart';

import '../../../ViewModel/bill_viewModel.dart';
import '../../../ViewModel/membership_viewmodel.dart';
import '../../../ViewModel/navbar_viewmodel.dart';
import '../../../ViewModel/payment_viewModel.dart';
import '../dialog/printCheck_dialog.dart';
import '../dialog/refund_dialog.dart';

class ShowBillView extends StatefulWidget {
  const ShowBillView({super.key});

  @override
  State<ShowBillView> createState() => _ShowBillViewState();
}

class _ShowBillViewState extends State<ShowBillView> {
  @override
  Widget build(BuildContext context) {
    final selectHold = context.watch<BillViewModels>().selectBillHold;
    final billDetail = context.watch<BillViewModels>().billDetail;
    final selectOrder = context.watch<BillViewModels>().selectOrder;
    final customer = context.watch<BillViewModels>().customer;
    final theme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          flex: selectHold == true ? 2 : 3,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: billDetail.isNotEmpty ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                if (selectHold)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLeftBtn(title: "Recall", icon: Icons.shortcut),
                      _buildRightBtn(title: "Cancel", icon: Icons.restore_from_trash),
                    ],
                  ),
                if (!selectHold)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLeftBtn(title: "Print Check", icon: Icons.print),
                      _buildRightBtn(title: "Refund", icon: Icons.receipt),
                    ],
                  ),
                if (billDetail.isEmpty) _buildNotFoundItem(),
                if (billDetail.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Summary",
                      style: TextStyle(fontSize: 20, color: theme.primary, fontWeight: FontWeight.w700),
                    ),
                  ),
                if (billDetail.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2, color: theme.onSecondary),
                      ),
                    ),
                    child: _buildMemberShipBar(),
                  ),
                if (billDetail.isNotEmpty)
                  Expanded(
                    child: _buildListItem(billDetail: billDetail),
                  ),
              ],
            ),
          ),
        ),
        if (billDetail.isNotEmpty)
          Expanded(
            flex: 1,
            child: Container(
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
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildRow(
                            header: "Total",
                            content: (selectOrder.totalAmount + selectOrder.discountAmount).toStringAsFixed(2),
                            color: theme.primary,
                          ),
                          _buildRow(
                            header: "Item Discount",
                            content: selectOrder.discountAmount.toStringAsFixed(2),
                            color: theme.primary,
                          ),
                          _buildRow(
                            header: "VAT 7%",
                            content: selectOrder.vatAmount.toStringAsFixed(2),
                            color: theme.primary,
                          ),
                          _buildRow(
                            header: "Pay Amount",
                            content: selectOrder.totalAmount.toStringAsFixed(2),
                            color: theme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (selectHold == true)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: theme.onPrimary, width: 1)),
                        ),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              //TODO click Payment in Bill Pages
                              int orderIdGet = 0;
                              await context
                                  .read<HomeViewModels>()
                                  .onPressedPayment(
                                    billOrder: selectOrder,
                                    billDetail: billDetail,
                                  )
                                  .then((value) async {
                                orderIdGet = value;
                                selectOrder.orderId = orderIdGet;
                                context.read<BaseViewModel>().getOrder();
                                context.read<BaseViewModel>().getOrderDetail();

                                context.read<PaymentViewModels>().filterPayment(
                                      billOrder: selectOrder,
                                      billDetail: billDetail,
                                      customer: customer,
                                    );
                                debugPrint("$orderIdGet");
                                context.read<BillViewModels>().filterOrderByStatus();
                                context.read<BillViewModels>().clearSelectOrderAndOrderDetail();
                              });
                              context.read<NavbarViewModels>().updateSelectPage(5);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                              backgroundColor: theme.onBackground,
                            ),
                            child: Text(
                              "Payment",
                              style: TextStyle(
                                fontSize: 28,
                                color: theme.background,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRow({required String header, required String content, required Color color}) {
    return Row(
      children: [
        Text(
          header,
          style: TextStyle(fontSize: header == "Pay Amount" ? 24 : 18, fontWeight: FontWeight.w700, color: color),
        ),
        const Spacer(),
        Text(content,
            style: TextStyle(fontSize: header == "Pay Amount" ? 24 : 18, fontWeight: FontWeight.w700, color: color)),
      ],
    );
  }

  Widget _buildListItem({required List<BillDetailModel> billDetail}) {
    final theme = Theme.of(context).colorScheme;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: billDetail.length,
      itemBuilder: (context, index) {
        if (billDetail.isNotEmpty) {
          return Container(
            height: 110,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 2, color: theme.onSecondary)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: AutoSizeText(
                    '(x${billDetail[index].productQty})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    maxFontSize: 18,
                    minFontSize: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Noto Sans Thai',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        billDetail[index].productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        maxFontSize: 18,
                        minFontSize: 1,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Noto Sans Thai',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AutoSizeText(
                        'Discount: ${billDetail[index].discount.toStringAsFixed(2)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        maxFontSize: 16,
                        minFontSize: 1,
                        style: TextStyle(
                          color: theme.onPrimary,
                          fontFamily: 'Noto Sans Thai',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AutoSizeText(
                        "Size: S ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        maxFontSize: 16,
                        minFontSize: 1,
                        style: TextStyle(
                          color: theme.onPrimary,
                          fontSize: 16,
                          fontFamily: 'Noto Sans Thai',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AutoSizeText(
                        "Color: Blue",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        maxFontSize: 16,
                        minFontSize: 1,
                        style: TextStyle(
                          color: theme.onPrimary,
                          fontSize: 16,
                          fontFamily: 'Noto Sans Thai',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (billDetail[index].discount != 0)
                        Expanded(
                          child: AutoSizeText(
                            (billDetail[index].subTotal + billDetail[index].discount).toStringAsFixed(2),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            maxFontSize: 15,
                            minFontSize: 1,
                            style: TextStyle(
                              color: theme.onPrimary,
                              fontSize: 15,
                              fontFamily: 'Noto Sans Thai',
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      Expanded(
                        flex: billDetail[index].discount != 0 ? 1 : 0,
                        child: AutoSizeText(
                          billDetail[index].subTotal.toStringAsFixed(2),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 15,
                          minFontSize: 1,
                          style: TextStyle(
                            color: theme.onBackground,
                            fontSize: 15,
                            fontFamily: 'Noto Sans Thai',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {}
      },
    );
  }

  Widget _buildLeftBtn({required String title, required IconData icon}) {
    final theme = Theme.of(context).colorScheme;
    final selectBillOrder = context.watch<BillViewModels>().selectOrder;
    final billDetail = context.watch<BillViewModels>().billDetail;
    final selectHold = context.watch<BillViewModels>().selectBillHold;
    onPressedRecall() {
      if (selectHold == true) {
        context.read<MembershipViewmodel>().checkCustomerByCustomerId(customerId: selectBillOrder.customerId);
        context.read<HomeViewModels>().getRecallOrderAndBillDetail(
              billOrder: selectBillOrder,
              billDetail: billDetail,
            );

        context.read<NavbarViewModels>().updateSelectPage(1);
      } else {
      }
    }

    return ElevatedButton.icon(
      onPressed: selectBillOrder.orderId == 0
          ? null
          : () {
              if (selectHold == true) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Confirm_Dialog(
                        text1: 'Are you sure you want to',
                        text2: 'recall bill?',
                        onTap_yes: () {
                          onPressedRecall();
                          Navigator.pop(context);
                        },
                        onTap_cancels: () {
                          Navigator.pop(context);
                        },
                        color_buttonyes: theme.onBackground,
                        image: 'assets/images/dialogImages/confirm.png',
                        colorText1: theme.primary,
                        colorText2: theme.primary);
                  },
                );
              } else if (!selectHold) {
                debugPrint("print");
                showDialog(
                  context: context,
                  builder: (context) {
                    return const PrintCheckDialog();
                  },
                );
              }
            },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        backgroundColor: theme.background,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: theme.onPrimary,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(
        icon,
        color: theme.onPrimary,
      ),
      label: AutoSizeText(
        title,
        maxFontSize: 15,
        minFontSize: 1,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: theme.onPrimary),
      ),
    );
  }

  Widget _buildRightBtn({required String title, required IconData icon}) {
    final theme = Theme.of(context).colorScheme;
    final selectHold = context.watch<BillViewModels>().selectBillHold;
    final selectBillOrder = context.watch<BillViewModels>().selectOrder;
    return ElevatedButton.icon(
      onPressed: selectBillOrder.orderId == 0
          ? null
          : () {
              if (selectHold == true) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Confirm_Dialog(
                        text1: 'Are you sure you want to',
                        text2: 'cancel bill?',
                        onTap_yes: () {
                          Navigator.pop(context);
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
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const RefundDialog();
                  },
                );
              }
            },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        backgroundColor: theme.background,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: theme.error,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(
        icon,
        color: theme.error,
      ),
      label: AutoSizeText(
        title,
        maxFontSize: 15,
        minFontSize: 1,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: theme.error,
        ),
      ),
    );
  }

  Widget _buildMemberShipBar() {
    final customer = context.watch<BillViewModels>().customer;
    final theme = Theme.of(context).colorScheme;
    return Container(
      height: 45,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/id.png',
            color: theme.onBackground,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                customer.customerId != 0 ? "K.${customer.fname}" : "Membership",
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
    );
  }

  Widget _buildNotFoundItem() {
    final theme = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/bill_Images/receipt.png',
            color: theme.onPrimary,
          ),
          Text(
            "Please select bill",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.onPrimary,
            ),
          ),
          Text(
            "for view detail or make transaction",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
