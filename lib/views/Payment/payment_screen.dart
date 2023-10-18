import 'package:flutter/material.dart';
//
import 'package:kepler_pos/views/Payment/widget/payamount_widget.dart';
import 'package:kepler_pos/views/Payment/widget/summaryPayment_widget.dart';
import 'package:kepler_pos/views/Payment/widget/titleMenu_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            // color: Colors.black12,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Column(children: [
              SizedBox(
                // color: Colors.deepOrange[200],
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.1,
                //BACK ,
                child: const TitleMenuwidget(),
              ),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.35,
                      //TODO SUMMARY
                      child: const SummaryPayment(),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    const Expanded(
                      //TODO PayAmount
                      child: Payamountwidget(),
                    ),
                  ],
                ),
              )
            ]),
          ),
        );
      },
    ));
  }
}
