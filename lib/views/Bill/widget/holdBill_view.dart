// import 'package:flutter/material.dart';
// import 'package:kepler_pos/views/Bill/widget/totalpayAmount.dart';
// import 'package:kepler_pos/widgets/Dialog/confirm_dialog.dart';
// import 'package:kepler_pos/widgets/Dialog/success_dialog.dart';
// import 'package:provider/provider.dart';
//
// import '../../../viewmodels/bill_viewmodel.dart';
// import '../../../viewmodels/home_viewmodel.dart';
// import '../../../viewmodels/base/navbar_viewmodel.dart';

// import '../../../widgets/ShowDedail/memberShip.dart';
//
// import 'billdetailsummary.dart';
//
// class HoldbillView extends StatefulWidget {
//   const HoldbillView({super.key});
//
//   @override
//   State<HoldbillView> createState() => _HoldbillViewState();
// }
//
// class _HoldbillViewState extends State<HoldbillView> {
//   @override
//   // void didChangeDependencies() {
//   //
//   //   super.didChangeDependencies();
//   //   Provider.of<Billviewmodel>(context, listen: false).fetchorder();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final billviewmodel = Provider.of<Billviewmodel>(context);
//     final screen = MediaQuery.of(context).size;
//     final theme = Theme.of(context);
//     final navbarviewmodel = Provider.of<NavbarViewModels>(context);
//     // final homestate = Provider.of<HomeState>(context);
//
//     void ontap_recall() {
//       // homestate.OntapPay(billviewmodel.showbilldetail);
//       // homestate.selectOrderId = billviewmodel.showbilldetail.first.orderID;
//       Navigator.pop(context);
//       showDialog(
//         context: context,
//         builder: (context) {
//           return Success_Dialog(text: 'Recall bill success!');
//         },
//       );
//       navbarviewmodel.updateSelectPage(1);
//     }
//
//     Future<void> ontap_cancelbill() async {
//       await billviewmodel.deleteorder(billviewmodel.selectshowdetailbill);
//       Navigator.pop(context);
//       showDialog(
//         context: context,
//         builder: (context) {
//           return Success_Dialog(text: 'Cancel bill success!');
//         },
//       );
//     }
//
//     return SizedBox(
//         child: billviewmodel.selectshowdetailbill != 0
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(screen.height * 0.02),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: InkWell(
//                             onTap: () {
//                               // homestate.OntapPay(billviewmodel.showbilldetail);
//                               // homestate.selectOrderId =
//                               //     billviewmodel.showbilldetail.first.orderID;
//                               // navbarviewmodel.updateSelectPage(1);
//                               // showDialog(
//                               //   context: context,
//                               //   builder: (context) {
//                               //     return Confirm_Dialog(
//                               //         text1: 'Are you sure you want to ',
//                               //         text2: 'recall bill?',
//                               //         onTap_yes: () {
//                               //           ontap_recall();
//                               //         },
//                               //         color_buttonyes: theme.indicatorColor,
//                               //         image: 'assets/confirm.png');
//                               //   },
//                               // );
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: ShapeDecoration(
//                                 color: theme.cardColor,
//                                 shape: RoundedRectangleBorder(
//                                   side: const BorderSide(
//                                       width: 1, color: Color(0xFF7A8C96)),
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                               ),
//                               height: screen.height * 0.08,
//                               child: const Center(
//                                   child: Text(
//                                 'recall',
//                                 style: TextStyle(
//                                   color: Color(0xFF5F717B),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               )),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: screen.width * 0.01,
//                         ),
//                         Expanded(
//                           child: InkWell(
//                             onTap: () async {
//                               // await billviewmodel.deleteorder(
//                               //     billviewmodel.selectshowdetailbill);
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return Confirm_Dialog(
//                                       text1: 'Are you sure you want to ',
//                                       text2: 'cancel bill?',
//                                       onTap_yes: () {
//                                         ontap_cancelbill();
//                                       },
//                                       onTap_cancels: () {
//
//                                       },
//                                       color_buttonyes: Colors.red,
//                                       image: 'assets/Cancel.png');
//                                 },
//                               );
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: ShapeDecoration(
//                                 color: theme.cardColor,
//                                 shape: RoundedRectangleBorder(
//                                   side: const BorderSide(
//                                       width: 1, color: Color(0xFFEC474F)),
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                               ),
//                               height: screen.height * 0.08,
//                               child: const Center(
//                                   child: Text(
//                                 'cancel',
//                                 style: TextStyle(
//                                   color: Color(0xFFEC474F),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               )),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       bottom: screen.height * 0.02,
//                       left: screen.height * 0.02,
//                       right: screen.height * 0.02,
//                     ),
//                     child: const Text(
//                       'summary',
//                       style:
//                           TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 24),
//                     child: MemberShipView(),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Divider(
//                       height: 5,
//                       color: theme.disabledColor,
//                     ),
//                   ),
//                   const BillDetailsummary(),
//                   const TotalpayAmount(),
//                 ],
//               )
//             : Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(screen.height * 0.02),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Opacity(
//                             opacity: 0.50,
//                             child: Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: ShapeDecoration(
//                                 color: theme.cardColor,
//                                 shape: RoundedRectangleBorder(
//                                   side: const BorderSide(
//                                       width: 1, color: Color(0xFF7A8C96)),
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                               ),
//                               height: screen.height * 0.08,
//                               child: const Center(
//                                   child: Text(
//                                 'recall',
//                                 style: TextStyle(
//                                   color: Color(0xFF5F717B),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               )),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: screen.width * 0.01,
//                         ),
//                         Expanded(
//                           child: Opacity(
//                             opacity: 0.50,
//                             child: Container(
//                               padding: const EdgeInsets.all(16),
//                               decoration: ShapeDecoration(
//                                 color: theme.cardColor,
//                                 shape: RoundedRectangleBorder(
//                                   side: const BorderSide(
//                                       width: 1, color: Color(0xFFEC474F)),
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                               ),
//                               height: screen.height * 0.08,
//                               child: const Center(
//                                   child: Text(
//                                 'cancel',
//                                 style: TextStyle(
//                                   color: Color(0xFFEC474F),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               )),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Opacity(
//                                 opacity: 0.50,
//                                 child: Icon(
//                                   Icons.receipt,
//                                   color: theme.disabledColor,
//                                   size: screen.height * 0.2,
//                                 ),
//                               ),
//                             ),
//                             Text('Please select bill',
//                                 style: TextStyle(color: theme.disabledColor)),
//                             SizedBox(
//                               height: screen.height * 0.02,
//                             ),
//                             Text('for view detail or make transaction.',
//                                 style: TextStyle(color: theme.disabledColor)),
//                           ]),
//                     ),
//                   )
//                 ],
//               ));
//   }
// }
