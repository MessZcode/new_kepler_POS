import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/bill_viewModel.dart';
import 'package:provider/provider.dart';

class PrintCheckDialog extends StatelessWidget {
  const PrintCheckDialog({super.key});
  //
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    final bill = Provider.of<BillViewModels>(context, listen: false);
    return AlertDialog(
      content: SizedBox(
        width: screen.width * 0.2,
        height: screen.height * 0.6,
        child: FutureBuilder<void>(
          future: bill.printBill(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator(
                radius: 20,
              );
            } else {
              final dataPrint = context.watch<BillViewModels>().dataPrint;
              return SizedBox(
                width: screen.width * 0.1,
                height: screen.height * 0.6,
                child: ListView.builder(
                  itemCount: dataPrint.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var center = dataPrint[index].posCenter;
                    var left = dataPrint[index].posLeft;
                    var right = dataPrint[index].posRight;

                    bool checkCenter =
                        center != null && left == null && right == null;
                    bool onlyLeft =
                        center == null && left != null && right == null;
                    bool onlyRight =
                        center == null && left == null && right != null;
                    bool between =
                        center == null && left != null && right != null;

                    return Row(
                      mainAxisAlignment: checkCenter
                          ? MainAxisAlignment.center
                          : onlyLeft
                              ? MainAxisAlignment.start
                              : onlyRight
                                  ? MainAxisAlignment.end
                                  : between
                                      ? MainAxisAlignment.spaceBetween
                                      : MainAxisAlignment.spaceAround,
                      children: [
                        if (checkCenter) Text(dataPrint[index].posCenter!.text),
                        if (onlyLeft) Text(dataPrint[index].posLeft!.text),
                        if (onlyRight) Text(dataPrint[index].posRight!.text),
                        if (between) Text(dataPrint[index].posLeft!.text),
                        if (between) Text(dataPrint[index].posRight!.text),
                      ],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
