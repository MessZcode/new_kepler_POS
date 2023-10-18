import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/bill_viewModel.dart';

class ListBillView extends StatefulWidget {
  const ListBillView({super.key});
  //
  @override
  State<ListBillView> createState() => _ListBillViewState();
}

class _ListBillViewState extends State<ListBillView> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final ScrollController controller = ScrollController();
    final bill = context.watch<BillViewModels>();

    return Expanded(
      child: Scrollbar(
          thumbVisibility: true,
          controller: controller,
          trackVisibility: false,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              childAspectRatio: 262 / 135,
            ),
            itemCount: bill.billOrder.length,
            controller: controller,
            itemBuilder: (context, index) {
              return InkWell(
                hoverColor: theme.onError,
                onTap: () {
                  context.read<BillViewModels>().onTapSelectOrder(bill.billOrder[index].orderId);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: ShapeDecoration(
                    color: bill.selectOrderById == bill.billOrder[index].orderId
                        ? theme.secondaryContainer
                        : theme.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color:
                            bill.selectOrderById == bill.billOrder[index].orderId ? theme.secondary : theme.background,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "#0000${bill.billOrder[index].orderId}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: theme.primary,
                            ),
                          ),
                          if (bill.selectOrderById == bill.billOrder[index].orderId)
                            Container(
                              width: 30,
                              height: 30,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: theme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Icon(Icons.check, color: theme.background),
                            )
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: theme.onSurface,
                      ),
                      Text.rich(
                        TextSpan(children: [
                          WidgetSpan(
                              child: SizedBox(
                            width: screen.width * 0.07,
                            child: Text('Cashier:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: theme.primary,
                                )),
                          )),
                          WidgetSpan(
                            child: SizedBox(
                              width: screen.width * 0.15,
                              child: Text(
                                '#000${bill.billOrder[index].userId}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: theme.primary,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        textAlign: TextAlign.center,
                      ),
                      Text.rich(
                        TextSpan(children: [
                          WidgetSpan(
                              child: SizedBox(
                            width: screen.width * 0.07,
                            child: Text('Start:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: theme.primary,
                                )),
                          )),
                          WidgetSpan(
                              child: SizedBox(
                            width: screen.width * 0.15,
                            child: Text(
                                '${DateFormat('MM/dd/yyyy').format(bill.billOrder[index].orderDate)}'
                                ' ${DateFormat('hh:mm a').format(bill.billOrder[index].orderDate)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: theme.primary,
                                )),
                          )),
                        ]),
                        textAlign: TextAlign.center,
                      ),
                      Text.rich(
                        TextSpan(children: [
                          WidgetSpan(
                              child: SizedBox(
                            width: screen.width * 0.07,
                            child: Text('Latest:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: theme.primary,
                                )),
                          )),
                          WidgetSpan(
                              child: SizedBox(
                            width: screen.width * 0.15,
                            child: Text(
                                '${DateFormat('MM/dd/yyyy').format(bill.billOrder[index].orderDate)}'
                                ' ${DateFormat('hh:mm a').format(bill.billOrder[index].orderDate)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: theme.primary,
                                )),
                          )),
                        ]),
                        textAlign: TextAlign.center,
                      ),
                      Text.rich(
                        TextSpan(children: [
                          WidgetSpan(
                              child: SizedBox(
                            width: screen.width * 0.07,
                            child: Text('Payment:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: theme.primary,
                                )),
                          )),
                          WidgetSpan(
                              child: SizedBox(
                            width: screen.width * 0.15,
                            child: Text(bill.billOrder[index].totalAmount.toStringAsFixed(2),
                                style: TextStyle(fontWeight: FontWeight.w500, color: theme.onBackground)),
                          )),
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
