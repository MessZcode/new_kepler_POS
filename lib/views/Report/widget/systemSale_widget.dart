import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/report_viewmodel.dart';

class SystemSale extends StatefulWidget {
  const SystemSale({super.key});

  @override
  State<SystemSale> createState() => _SystemSaleState();
}

class _SystemSaleState extends State<SystemSale> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final report = Provider.of<ReportViewmodel>(context);

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screen.height * 0.01),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: theme.onError),
              height: screen.height * 0.1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screen.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Padding(
                        padding: EdgeInsets.only(right: screen.width * 0.008),
                        child: Text(
                          'Day',
                          style: TextStyle(color: theme.primary, fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 35,
                        child: TextFormField(
                            controller: report.startdateTime_system,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101),
                              );
                              report.selectStartDate(pickedDate!);
                            },
                            decoration: const InputDecoration(
                              hintText: 'yyyy/mm/dd',
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screen.width * 0.01),
                        child: Text('-',
                            style: TextStyle(fontWeight: FontWeight.w500, color: theme.primary, fontSize: 16)),
                      ),
                      SizedBox(
                        width: 100,
                        height: 35,
                        child: TextFormField(
                            controller: report.endtdateTime_system,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));
                              report.selectEndDate(pickedDate!);
                            },
                            decoration: const InputDecoration(
                              hintText: 'yyyy/mm/dd',
                            )),
                      ),
                    ]),
                    ElevatedButton(
                        onPressed: () async {
                          await report.fillterSystemsale();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(theme.onBackground),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text(
                            'search',
                            style: TextStyle(color: theme.background),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
