// import 'package:flutter/material.dart';
// import 'package:kepler_pos/models/payment_model.dart';
// import 'package:provider/provider.dart';
//
// import '../../../viewmodels/bill_viewmodel.dart';
// import '../../../viewmodels/home_viewmodel.dart';
// import '../../../viewmodels/base/navbar_viewmodel.dart';
// import '../../../viewmodels/payment_viewmodel.dart';

// class TotalpayAmount extends StatelessWidget {
//   const TotalpayAmount({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screen = MediaQuery.of(context).size;
//     final theme = Theme.of(context);
//     final billviewmodel = Provider.of<Billviewmodel>(context);
//     final navbarviewmodel = Provider.of<NavbarViewModels>(context);
//     // final homestate = Provider.of<HomeState>(context);
//     final paymentviewmodel = Provider.of<Paymentviewmodel>(context);
//     paymentviewmodel.fetchOrderpayment();
//
//     void tap_pay() {
//       // homestate.OntapPay(billviewmodel.showbilldetail);
//
//       //homestate.selectOrderId = billviewmodel.showbilldetail.first.orderID;
//
//       // paymentviewmodel.updateOrderRemaining(
//       //   billviewmodel.showbilldetail.first.orderID,
//       //   // homestate.billProduct.first.payAmount,
//       // );
//       // navbarviewmodel.updateSelectPage(5);
//     }
//
//     return Container(
//       width: screen.width * 0.3,
//       height: screen.height * 0.35,
//       decoration: BoxDecoration(
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
//           color: theme.canvasColor),
//       child:
//           Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: SizedBox(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Total',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 18)),
//                       Text(
//                           // '${homestate.billProduct.first.total.toStringAsFixed(2)}',
//                         "",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 18)),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Item Discount',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 18)),
//                       Text(
//                           // '${homestate.billProduct.first.itemDiscount.toStringAsFixed(2)}',
//                         "",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 18)),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('VAT 7%',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 18)),
//                       Text(
//                           // '${homestate.billProduct.first.vat.toStringAsFixed(2)}',
//                         "",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 18)),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Pay Amount',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 28)),
//                       Text(
//                           // '${homestate.billProduct.first.payAmount.toStringAsFixed(2)}',
//                         "",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 18)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Container(
//           width: screen.width * 0.3,
//           // height: screen.height * 0.11,
//           // color: Colors.pink,
//
//           child: billviewmodel.numberselectbill == 2
//               ? SizedBox()
//               : Column(children: [
//                   Divider(
//                     height: 1,
//                     color: theme.disabledColor,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: screen.width * 0.01,
//                         ),
//                         Expanded(
//                           child: InkWell(
//                             onTap: () {
//                               tap_pay();
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(12),
//                               decoration: ShapeDecoration(
//                                 color: theme.indicatorColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 shadows: const [
//                                   BoxShadow(
//                                     color: Color(0x0A000000),
//                                     blurRadius: 10,
//                                     offset: Offset(0, 10),
//                                     spreadRadius: -5,
//                                   ),
//                                   BoxShadow(
//                                     color: Color(0x19000000),
//                                     blurRadius: 25,
//                                     offset: Offset(0, 20),
//                                     spreadRadius: -5,
//                                   )
//                                 ],
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 'Pay',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: theme.cardColor,
//                                     fontWeight: FontWeight.w700),
//                               )),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ]),
//         )
//       ]),
//     );
//   }
// }
