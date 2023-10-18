// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../viewmodels/bill_viewmodel.dart';
//

// class BillDetailsummary extends StatelessWidget {
//   const BillDetailsummary({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final screen = MediaQuery.of(context).size;
//     // final homeState = Provider.of<HomeState>(context);
//     final billviewmodel = Provider.of<Billviewmodel>(context);
//
//     return Expanded(
//         child: Container(
//       padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: billviewmodel.showbilldetail.length,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                       flex: 1,
//                       child: Text(
//                         '(x${billviewmodel.showbilldetail[index].quantity})',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontFamily: 'Noto Sans Thai',
//                           fontWeight: FontWeight.w700,
//                         ),
//                       )),
//                   Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '${billviewmodel.showbilldetail[index].productName}',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Noto Sans Thai',
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           Text(
//                             'Discount: ${billviewmodel.showbilldetail[index].pricePerUnit}',
//                             style: TextStyle(
//                               color: theme.disabledColor,
//                               // fontSize: 16,
//                               fontFamily: 'Noto Sans Thai',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             'Size: ${billviewmodel.showbilldetail[index].size}',
//                             style: TextStyle(
//                               color: theme.disabledColor,
//                               fontSize: 16,
//                               fontFamily: 'Noto Sans Thai',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             'Color:  ${billviewmodel.showbilldetail[index].color}',
//                             style: TextStyle(
//                               color: theme.disabledColor,
//                               fontSize: 16,
//                               fontFamily: 'Noto Sans Thai',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           )
//                         ],
//                       )),
//                   Expanded(
//                       flex: 1,
//                       child: Text(
//                         '${billviewmodel.showbilldetail[index].subtotal}',
//                         style: TextStyle(
//                           color: theme.disabledColor,
//                           fontSize: 18,
//                           fontFamily: 'Noto Sans Thai',
//                           fontWeight: FontWeight.w500,
//                           decoration: TextDecoration.lineThrough,
//                         ),
//                       )),
//                   Expanded(
//                       flex: 1,
//                       child: Text(
//                         '${billviewmodel.showbilldetail[index].pricePerUnit}',
//                         style: TextStyle(
//                           color: theme.indicatorColor,
//                           fontSize: 18,
//                           fontFamily: 'Noto Sans Thai',
//                           fontWeight: FontWeight.w700,
//                         ),
//                       )),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 12),
//                 child: Divider(
//                   height: 5,
//                   color: theme.disabledColor,
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     ));
//   }
// }
