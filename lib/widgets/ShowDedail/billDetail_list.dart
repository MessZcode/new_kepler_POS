import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/widgets/Dialog/confirm_dialog.dart';

import 'package:provider/provider.dart';

import '../../ViewModel/home_viewModels.dart';

//
class Bill_Detail_List extends StatefulWidget {
  const Bill_Detail_List({
    super.key,
  });

  @override
  State<Bill_Detail_List> createState() => _Bill_Detail_ListState();
}

class _Bill_Detail_ListState extends State<Bill_Detail_List> {
  Timer? timer;
  void onLongPress(int productId, {required bool increment}) {
    timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (increment) {
        context.read<HomeViewModels>().onTapAdd(productId);
      } else {
        context.read<HomeViewModels>().onTapRemove(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final billDetail = context.watch<HomeViewModels>().billDetail;
    final screen = MediaQuery.of(context).size;

    if (!billDetail.isNotEmpty) {
      return _buildNotFoundBill(context: context);
    }
    return Expanded(
        child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: billDetail.length,
      itemBuilder: (context, index) {
        return Container(
          //todo edit list detail product
          padding: EdgeInsets.symmetric(horizontal: screen.width * 0.01),
          height: screen.height * 0.18,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 2, color: theme.onError),
                  top: BorderSide(width: index > 0 ? 0 : 2, color: theme.onError))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //row1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      billDetail[index].productName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: theme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      alignment: Alignment.topRight,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Confirm_Dialog(
                                text1: 'Are you sure you want to',
                                text2: 'cancel item?',
                                onTap_yes: () {
                                  context.read<HomeViewModels>().onTapProduct(billDetail[index].productId);
                                  Navigator.pop(context);
                                },
                                onTap_cancels: () {
                                  Navigator.pop(context);
                                },
                                color_buttonyes: theme.error,
                                image: 'assets/images/dialogImages/Cancel.png',
                                colorText1: theme.primary,
                                colorText2: theme.primary);
                          },
                        );
                      },
                      icon: Icon(Icons.close, color: theme.onPrimary),
                    ),
                  ),
                ],
              ),
              //row2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      billDetail[index].priceperunit.toString(),
                      minFontSize: 1,
                      maxFontSize: 28,
                      overflowReplacement: const ClipRRect(),
                      maxLines: 1,
                      style: TextStyle(
                        color: theme.onBackground,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.read<HomeViewModels>().onTapRemove(billDetail[index].productId),
                        onLongPress: () => onLongPress(billDetail[index].productId, increment: false),
                        onLongPressEnd: (_) => setState(() {
                          timer?.cancel();
                        }),
                        child: Container(
                          padding: EdgeInsets.all(screen.height * 0.01),
                          decoration: ShapeDecoration(
                            color: theme.onError,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: theme.background,
                            size: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screen.width * 0.01),
                        child: AutoSizeText(
                          billDetail[index].productQty.toString(),
                          maxLines: 1,
                          maxFontSize: 24,
                          minFontSize: 1,
                          overflowReplacement: const ClipRRect(),
                          style: TextStyle(
                            fontSize: 24,
                            color: theme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.read<HomeViewModels>().onTapAdd(billDetail[index].productId),
                        onLongPress: () => onLongPress(billDetail[index].productId, increment: true),
                        onLongPressEnd: (_) => setState(() {
                          timer?.cancel();
                        }),
                        child: Container(
                          padding: EdgeInsets.all(screen.height * 0.01),
                          decoration: ShapeDecoration(
                            color: theme.onBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            color: theme.background,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget _buildNotFoundBill({required BuildContext context}) {
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 100, color: theme.onPrimary),
            SizedBox(
              height: screen.height * 0.01,
            ),
            Text('Please add some items', style: TextStyle(color: theme.onPrimary)),
            Text('from the menu', style: TextStyle(color: theme.onPrimary)),
          ],
        ),
      ),
    );
  }
}
