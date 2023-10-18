// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
//
// class SelectOption_dialog extends StatefulWidget {
//   const SelectOption_dialog({super.key});

//   @override
//   State<SelectOption_dialog> createState() => _SelectOption_dialogState();
// }
//
// class _SelectOption_dialogState extends State<SelectOption_dialog> {
//   // bool tabtextfeild = false;
//   final TextEditingController textEditingController = TextEditingController();
//
//   Widget _selectSize(int id, String text) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {});
//       },
//       child: Container(
//         margin: const EdgeInsets.only(right: 15),
//         // width: 50,
//         // height: 50,
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//         decoration: ShapeDecoration(
//           color: const Color(0xFF1CAF82),
//           shape: RoundedRectangleBorder(
//             side: BorderSide(width: 1, color: const Color(0xFF1CAF82)),
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//               color: Color(0xFFFEFEFE),
//               fontSize: 26,
//               fontFamily: 'Noto Sans Thai',
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _selectColor(int id, dynamic color) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {});
//       },
//       child: Container(
//           margin: const EdgeInsets.only(right: 15),
//           width: 50,
//           padding: const EdgeInsets.all(5),
//           clipBehavior: Clip.antiAlias,
//           decoration: ShapeDecoration(
//             shape: RoundedRectangleBorder(
//               side: BorderSide(width: 1, color: Color(color)),
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),
//           child: Container(
//             decoration: ShapeDecoration(
//               color: Color(color),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           )),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               // tabtextfeild = false;
//             });
//           },
//           child: AlertDialog(
//             contentPadding: const EdgeInsets.all(16),
//             actionsPadding: const EdgeInsets.all(0),
//             elevation: 0,
//             titlePadding: const EdgeInsets.all(24),
//
//             //title
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Select Option",
//                   style: TextStyle(
//                     color: Color(0xFF252525),
//                     fontSize: 32,
//                     fontFamily: 'Noto Sans Thai',
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: const Icon(Icons.cancel),
//                 ),
//               ],
//             ),
//
//             //content
//             content: Container(
//               width: MediaQuery.of(context).size.width * 0.6,
//               // color: Colors.blue[50],
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       // color: Colors.blue[100],
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(16),
//                             clipBehavior: Clip.antiAlias,
//                             decoration: ShapeDecoration(
//                               color: const Color(0xFFF4F6F7),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(24),
//                               ),
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.35,
//                                         decoration: ShapeDecoration(
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(16),
//                                             ),
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/Image5.png'),
//                                               fit: BoxFit.cover,
//                                             )),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const Row(
//                                   children: [
//                                     Expanded(
//                                         child: AutoSizeText(
//                                       maxFontSize: 24,
//                                       minFontSize: 1,
//                                       maxLines: 1,
//                                       overflowReplacement: ClipRRect(),
//                                       'Wide Leg Jeans',
//                                       style: TextStyle(
//                                         color: Color(0xFF252525),
//                                         fontSize: 24,
//                                         fontFamily: 'Noto Sans Thai',
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     )),
//                                   ],
//                                 ),
//                                 const Row(
//                                   children: [
//                                     Expanded(
//                                         child: AutoSizeText(
//                                       '550.00฿',
//                                       overflowReplacement: ClipRRect(),
//                                       maxLines: 1,
//                                       minFontSize: 1,
//                                       maxFontSize: 24,
//                                       style: TextStyle(
//                                         color: Color(0xFF1CAF82),
//                                         fontSize: 24,
//                                         fontFamily: 'Noto Sans Thai',
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     )),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.03,
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Container(
//                               // color: Colors.green[100],
//                               child: Row(
//                                 children: [
//                                   // Container(
//                                   //   height: MediaQuery.of(context).size.height *
//                                   //       0.07,
//                                   //   padding: const EdgeInsets.symmetric(
//                                   //       horizontal: 16, vertical: 8),
//                                   //   decoration: ShapeDecoration(
//                                   //     color: const Color(0xFFFFEBD4),
//                                   //     shape: RoundedRectangleBorder(
//                                   //       borderRadius: BorderRadius.circular(50),
//                                   //     ),
//                                   //   ),
//                                   //   child: const Center(
//                                   //     child: Text(
//                                   //       'Discount : 5%',
//                                   //       style: TextStyle(
//                                   //         color: Color(0xFFFD6412),
//                                   //         fontSize: 20,
//                                   //         fontFamily: 'Noto Sans Thai',
//                                   //         fontWeight: FontWeight.w700,
//                                   //       ),
//                                   //     ),
//                                   //   ),
//                                   // )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.01,
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       // color: Colors.cyanAccent[100],
//                       child: Column(
//                         children: [
//                           const Row(
//                             children: [
//                               Text(
//                                 'Option',
//                                 style: TextStyle(
//                                   color: Color(0xFF1CAF82),
//                                   fontSize: 24,
//                                   fontFamily: 'Noto Sans Thai',
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Row(
//                             children: [
//                               Text(
//                                 'Size',
//                                 style: TextStyle(
//                                   color: Color(0xFF252525),
//                                   fontSize: 24,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: SizedBox(
//                               height: 50,
//                               child: _selectSize(1, 's'),
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(top: 16, bottom: 16),
//                             child: Divider(
//                               color: Color(0xFFCBD3D6),
//                               height: 5,
//                             ),
//                           ),
//                           const Row(
//                             children: [
//                               Text(
//                                 'Color : Blue',
//                                 style: TextStyle(
//                                   color: Color(0xFF252525),
//                                   fontSize: 24,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: SizedBox(
//                                 height: 50,
//                                 child: _selectColor(
//                                   1,
//                                   0xFF80A8D2,
//                                 )),
//                             // _selectColor(0xFF3E566E),
//                             // _selectColor(0xFF5D7DA3),
//                             // _selectColor(0xFF80A8D2),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(top: 16, bottom: 16),
//                             child: Divider(
//                               color: Color(0xFFCBD3D6),
//                               height: 5,
//                             ),
//                           ),
//                           TextFormField(
//                             maxLength: 100,
//                             maxLines: 2,
//                             controller: textEditingController,
//                             onTap: () {
//                               // tabtextfeild = true;
//                               setState(() {
//                                 print('tap textfeild');
//                               });
//                             },
//                             style: const TextStyle(
//                               color: Color(0xFF252525),
//                               fontSize: 24,
//                               fontFamily: 'Noto Sans Thai',
//                               fontWeight: FontWeight.w500,
//                             ),
//                             decoration: InputDecoration(
//                                 // labelText: '${textEditingController.text}',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                   // borderSide: const BorderSide(color: Color(0xFFCBD3D6),),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   gapPadding: 12,
//                                   borderSide: const BorderSide(
//                                     color: Color(0xFFCBD3D6),
//                                   ),
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 hintText: 'Note',
//                                 hintStyle: const TextStyle(
//                                   color: Color(0xFFCBD3D6),
//                                   fontSize: 24,
//                                   fontFamily: 'Noto Sans Thai',
//                                   fontWeight: FontWeight.w500,
//                                 )),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             //actions
//             actions: [
//               Container(
//                 color: const Color(0xFFF4F6F7),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         // color: Colors.green,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               const Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     '550.00',
//                                     style: TextStyle(
//                                       color: Color(0xFF7A8C96),
//                                       fontSize: 24,
//                                       fontFamily: 'Noto Sans Thai',
//                                       fontWeight: FontWeight.w500,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     'Total:',
//                                     style: TextStyle(
//                                       color: Color(0xFF252525),
//                                       fontSize: 24,
//                                       fontFamily: 'Noto Sans Thai',
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                   Text(
//                                     '533.00',
//                                     style: TextStyle(
//                                       color: Color(0xFF1CAF82),
//                                       fontSize: 36,
//                                       fontFamily: 'Noto Sans Thai',
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 1),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                         flex: 1,
//                                         child: Container(
//                                           // height: 50,
//                                           // color: Colors.cyanAccent,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               InkWell(
//                                                 onTap: () {
//                                                   setState(() {});
//                                                 },
//                                                 child: Container(
//                                                   width: 50,
//                                                   height: 50,
//                                                   padding:
//                                                       const EdgeInsets.all(6),
//                                                   decoration: ShapeDecoration(
//                                                     color:
//                                                         const Color(0xFFE9EAF0),
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               16),
//                                                     ),
//                                                   ),
//                                                   child: const Center(
//                                                       child: Icon(
//                                                     Icons.remove,
//                                                     color: Colors.white,
//                                                   )),
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 width: 80,
//                                                 height: 50,
//                                                 child: Center(
//                                                   child: Text(
//                                                     'ok',
//                                                     style: TextStyle(
//                                                       color: Color(0xFF252525),
//                                                       fontSize: 28,
//                                                       fontFamily:
//                                                           'Noto Sans Thai',
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   setState(() {});
//                                                 },
//                                                 child: Container(
//                                                   width: 50,
//                                                   height: 50,
//                                                   padding:
//                                                       const EdgeInsets.all(6),
//                                                   decoration: ShapeDecoration(
//                                                     color:
//                                                         const Color(0xFF1CAF82),
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               16),
//                                                     ),
//                                                   ),
//                                                   child: const Center(
//                                                       child: Icon(
//                                                     Icons.add,
//                                                     color: Colors.white,
//                                                   )),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         )),
//                                     Expanded(
//                                         flex: 1,
//                                         child: InkWell(
//                                           onTap: () {
//                                             Navigator.of(context).pop();
//                                           },
//                                           child: Container(
//                                             // height: 50,
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 32, vertical: 10),
//                                             decoration: ShapeDecoration(
//                                               color: const Color(0xFF1CAF82),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(16),
//                                               ),
//                                               shadows: const [
//                                                 BoxShadow(
//                                                   color: Color(0x0A000000),
//                                                   blurRadius: 10,
//                                                   offset: Offset(0, 10),
//                                                   spreadRadius: -5,
//                                                 ),
//                                                 BoxShadow(
//                                                   color: Color(0x19000000),
//                                                   blurRadius: 25,
//                                                   offset: Offset(0, 20),
//                                                   spreadRadius: -5,
//                                                 )
//                                               ],
//                                             ),
//                                             child: const Center(
//                                                 child: Text(
//                                               'Add Item',
//                                               style: TextStyle(
//                                                 color: Color(0xFFFEFEFE),
//                                                 fontSize: 28,
//                                                 fontFamily: 'Noto Sans Thai',
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                             )),
//                                           ),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         // Positioned(
//         //   left: 0,
//         //   right: 0,
//         //   bottom: 0,
//         //   child: tabtextfeild
//         //       ? Keyboard_dialog(
//         //           onValueSelected: (dynamic getdata) {
//         //             final currentText = textEditingController.text;
//         //             final newText = currentText + getdata;
//         //             final va = getdata;
//         //             print(va);
//         //             if (getdata == '') {
//         //               String updatedText = newText.substring(
//         //                   0, newText.length - 1); // ลบอักขระสุดท้ายออก
//         //               setState(() {
//         //                 textEditingController.text = updatedText;
//         //               }); // กำหนดค่ากลับให้กับ TextEditingController
//         //             } else if (getdata == 'space') {
//         //               // เพิ่มช่องว่าง (space)
//         //               final currentText = textEditingController.text;
//         //               final newText = '$currentText ';
//         //               textEditingController.text = newText;
//         //             } else {
//         //               textEditingController.text = newText;
//         //             }
//         //           },
//         //         )
//         //       : SizedBox(),
//         // ),
//       ],
//     );
//   }
// }
