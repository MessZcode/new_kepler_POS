import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/report_viewmodel.dart';
import 'package:kepler_pos/views/Report/widget/row_widget.dart';
import 'package:kepler_pos/views/Report/widget/systemSale_widget.dart';
import 'package:kepler_pos/views/Report/widget/topSale_widget.dart';
import 'package:provider/provider.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    final report = Provider.of<ReportViewmodel>(context, listen: false);
    report.fetchTablePayment();
    report.fethTopsale();
    // context.watch<ReportViewmodel>().fetchTablePayment();
    // context.watch<ReportViewmodel>().fethTopsale();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final report = Provider.of<ReportViewmodel>(context);

    return Container(
        padding: EdgeInsets.all(screen.height * 0.005),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Report', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(
                  bottom: screen.height * 0.02,
                  left: screen.height * 0.01,
                  top: screen.height * 0.02,
                  right: screen.height * 0.02,
                ),
                child: Container(
                  padding: EdgeInsets.all(screen.width * 0.01),
                  decoration:
                      BoxDecoration(color: theme.background, borderRadius: const BorderRadius.all(Radius.circular(24))),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) => Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'System sale',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: theme.primary),
                          )
                        ],
                      ),
                      const SystemSale(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: theme.background,
                        ),
                        child: Column(children: [
                          RowtText(title: 'Sale Amount', value: report.saleAmount),
                          RowtText(title: 'Discount', value: report.Discount),
                          RowtText(title: 'Net Amount', value: report.NetAmount),
                          RowtText(title: 'Vat', value: report.Vat),
                          Padding(
                            padding: EdgeInsets.only(top: screen.height * 0.03),
                            child: RowtText(title: 'Cash', value: report.Cash),
                          ),
                          RowtText(title: 'Paid in', value: report.Paidin),
                          RowtText(title: 'Paid out', value: report.Paidout),
                          RowtText(title: 'Cash in drawer', value: report.Cashindrawer),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: screen.width * 0.02, vertical: screen.height * 0.01),
                            child: const Row(
                              children: [
                                Text(
                                  'Payment',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RowtText(title: 'Cash', value: report.Cash),
                          RowtText(title: 'Credit', value: report.Credit),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screen.height * 0.03),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Top sale',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                            )
                          ],
                        ),
                      ),
                      const Topsale(),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.background,
                          ),
                          child: Column(children: [
                            ListView.builder(
                              itemCount: report.listtopSale.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screen.width * 0.02, vertical: screen.height * 0.01),
                                  child: Container(
                                    decoration:
                                        const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(report.listtopSale[index].title,
                                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(right: screen.height * 0.49),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  // decoration: BoxDecoration(color: Colors.indigo[100]),
                                                  width: screen.width * 0.05,
                                                  child: Text('${report.listtopSale[index].qty}',
                                                      style:
                                                          const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerRight,
                                                // decoration: BoxDecoration(color: Colors.purple[100]),
                                                width: screen.width * 0.1,
                                                child: Text(
                                                  '${report.listtopSale[index].value.toStringAsFixed(0)}',
                                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ]))
                    ]),
                  ),
                )),
          ),
        ]));
  }
}
