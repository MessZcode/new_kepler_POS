import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/report_viewmodel.dart';

class Topsale extends StatefulWidget {
  const Topsale({super.key});

  @override
  State<Topsale> createState() => _TopsaleState();
}

class _TopsaleState extends State<Topsale> {
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
              // height: screen.height * 0.1,

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screen.width * 0.05, vertical: screen.height * 0.02),
                child: Column(
                  children: [
                    Row(
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
                                controller: report.endtdateTime_top,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101),
                                  );
                                  report.selectEndDateT(pickedDate!);
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
                                controller: report.startdateTime_top,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));
                                  report.selectStartDateT(pickedDate!);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'yyyy/mm/dd',
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screen.width * 0.01),
                            child: Row(
                              children: [
                                Text(
                                  'Top',
                                  style: TextStyle(color: theme.primary, fontSize: 20, fontWeight: FontWeight.w700),
                                ),
                                InkWell(
                                  onTap: () {
                                    report.selecttop();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration:
                                        BoxDecoration(color: theme.onSurface, borderRadius: BorderRadius.circular(4)),
                                    child: Icon(report.fillterTop ? Icons.arrow_upward : Icons.arrow_downward),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screen.width * 0.01),
                            child: Row(
                              children: [
                                Text(
                                  'Sort',
                                  style: TextStyle(color: theme.primary, fontSize: 20, fontWeight: FontWeight.w700),
                                ),
                                InkWell(
                                  onTap: () {
                                    report.selectsort();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration:
                                        BoxDecoration(color: theme.onSurface, borderRadius: BorderRadius.circular(4)),
                                    child: Icon(report.fillterSort ? Icons.arrow_upward : Icons.arrow_downward),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                        ElevatedButton(
                            onPressed: () async {
                              await report.fillterTopsale();
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
