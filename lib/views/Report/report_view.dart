import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
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
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Column(children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Menu'), Text('Select')],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: screen.height * 0.01),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.cyan[100]),
                          height: screen.height * 0.1,
                          child: const Text('Select fillter', textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple[100],
                    ),
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: const <TableRow>[
                        TableRow(decoration: BoxDecoration(color: Colors.teal), children: [
                          Text('1'),
                          Text('1'),
                          Text('1'),
                        ]),
                        TableRow(decoration: BoxDecoration(color: Colors.teal), children: [
                          Text('2'),
                          Text('2'),
                          Text('2'),
                        ]),
                      ],
                    ))
              ]),
            ),
          ),
        )
      ]),
    );
  }
}
