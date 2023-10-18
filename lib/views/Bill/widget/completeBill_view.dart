// import 'package:flutter/material.dart';
// import 'package:kepler_pos/views/Bill/widget/totalpayAmount.dart';
// import 'package:provider/provider.dart';

// import '../../../viewmodels/bill_viewmodel.dart';
// import '../../../viewmodels/home_viewmodel.dart';
// import '../../../viewmodels/base/navbar_viewmodel.dart';
// import '../../../widgets/ShowDedail/memberShip.dart';
// import '../dialog/printCheck_dialog.dart';
// import '../dialog/refund_dialog.dart';
// import 'billdetailsummary.dart';
//
// class CompletebillView extends StatefulWidget {
//   const CompletebillView({super.key});
//
//   @override
//   State<CompletebillView> createState() => _CompletebillViewState();
// }
//
// class _CompletebillViewState extends State<CompletebillView> {
//   @override
//   // void didChangeDependencies() {
//   //
//   //   super.didChangeDependencies();
//   //   Provider.of<Billviewmodel>(context, listen: false).fetchorder();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final screen = MediaQuery.of(context).size;
//     final theme = Theme.of(context);
//     final billviewmodel = Provider.of<Billviewmodel>(context);
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
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return const PrintCheckDialog();
//                                 },
//                               );
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
//                                 'Print Check',
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
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return const RefundDialog();
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
//                                 'Refund',
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
//                                 'Print Check',
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
//                                 'Refund',
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
