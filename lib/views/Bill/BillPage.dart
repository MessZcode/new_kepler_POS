import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Bill/widget/listbill.dart';
import 'package:kepler_pos/views/Bill/widget/showbill.dart';
import 'package:kepler_pos/widgets/Dialog/confirm_dialog.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/base_viewmodel.dart';
import '../../ViewModel/bill_viewModel.dart';

//
class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  _getOrder() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BillViewModels>().clearSelectOrderAndOrderDetail();
      context.read<BillViewModels>().filterOrderByStatus();
      context.read<BillViewModels>().filterShowDetailByOrderId();
    });
  }

  Future<void> _onClickDeleteAllBillHold() async {
    await context.read<BillViewModels>().deleteAllBillHold();
    await context.read<BaseViewModel>().getOrder();
    await context.read<BaseViewModel>().getOrderDetail();
    context.read<BillViewModels>().clearSelectOrderAndOrderDetail();
    _getOrder();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getOrder();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final selectBill = context.watch<BillViewModels>().selectBillHold;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Bill',
                          maxLines: 1,
                          maxFontSize: 28,
                          minFontSize: 0,
                          presetFontSizes: [28, 25],
                          style: TextStyle(
                            fontSize: 28,
                            color: theme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: SizedBox(
                              height: screen.height * 0.075,
                              child: Scrollbar(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                          onPressed: () => context.read<BillViewModels>().setSelectBill(true),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                              horizontal: 24,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            backgroundColor: selectBill ? theme.onBackground : theme.onError,
                                          ),
                                          child: AutoSizeText(
                                            'Hold Bills',
                                            maxFontSize: 20,
                                            minFontSize: 1,
                                            style: TextStyle(
                                              color: selectBill ? theme.background : theme.onPrimary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => context.read<BillViewModels>().setSelectBill(false),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: 24,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        backgroundColor: selectBill ? theme.onError : theme.onBackground,
                                      ),
                                      child: AutoSizeText(
                                        'Complete Bills',
                                        maxFontSize: 20,
                                        minFontSize: 1,
                                        style: TextStyle(
                                          color: selectBill ? theme.onPrimary : theme.background,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 14),
                          child: Divider(
                            height: 1,
                            color: Colors.black12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Toal ${context.watch<BillViewModels>().billOrder.length} bill",
                                  style: TextStyle(
                                    color: theme.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  )),
                              if (selectBill == true)
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Confirm_Dialog(
                                                text1: 'Are you sure you want to',
                                                text2: 'cancel all bill?',
                                                onTap_yes: () async {
                                                  if (selectBill) {
                                                    await _onClickDeleteAllBillHold();
                                                  } else {}
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
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: theme.background,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                              side: BorderSide(color: theme.error))),
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete_forever_outlined, color: theme.error),
                                          AutoSizeText(
                                            'Cancel All Bill',
                                            style: TextStyle(
                                              color: theme.error,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                            ],
                          ),
                        ),
                        const ListBillView(),
                      ],
                    ),
                  )),
              Container(
                width: screen.width * 0.26,
                height: screen.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.background,
                ),
                child: const ShowBillView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
