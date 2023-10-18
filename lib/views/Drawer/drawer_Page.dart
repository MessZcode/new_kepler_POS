import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:kepler_pos/views/Drawer/widget/expense.dart';
import 'package:kepler_pos/views/Drawer/widget/opendrewer.dart';
import 'package:kepler_pos/views/Drawer/widget/paid_in.dart';
import 'package:provider/provider.dart';
//
import '../../ViewModel/drawer_viewmodel.dart';
import '../../models/drawer_model.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     Provider.of<Detaildrawer>(context, listen: false).updateCurrentCash(0.0);
  //   });
  // }

  double dblTotalValues1 = 0;
  final List<Tender> lstTender = [];
  int textindex = 0;
  List<TextEditingController> textEditeController = [];
  void navigateToPadinPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Padin(paidType: 'Padin Page')),
    );

    if (result != null) {
      setState(() {
        for (int i = 0; i < lstTender.length; i++) {
          if (textindex == i) {
            int? dblUserInput = 0;
            dblUserInput = int.tryParse(textEditeController[textindex].text);

            dblUserInput ??= 0;

            lstTender[i].userInputQty = dblUserInput;

            lstTender[i].calculatedTotalValue = dblUserInput * lstTender[i].TenderValue.toDouble();
          }

          //total calculate
          dblTotalValues1 += lstTender[i].calculatedTotalValue;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final detailState = Detaildrawer();
    final theme = Theme.of(context).colorScheme;
    const maxLines = 1;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: 24,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'Drawer',
                        style: TextStyle(
                          color: theme.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: maxLines,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.67,
                        padding: const EdgeInsets.all(30),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: theme.onBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              'Current Cash',
                              style: TextStyle(
                                color: theme.background,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: maxLines,
                            ),
                            const SizedBox(height: 16),
                            Consumer<DrawerViewModels>(
                              builder: (context, value, child) {
                                return Text(
                                  value.currentCash.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: theme.background,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Flexible(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: 24,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const Padin(
                                                paidType: "1",
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.325,
                                          padding: const EdgeInsets.all(24),
                                          decoration: ShapeDecoration(
                                            color: theme.background,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 1, color: theme.onBackground),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage('assets/hpaid-in 1.png'),
                                                    // เปลี่ยนเป็นตำแหน่งและชื่อไฟล์ภาพที่คุณต้องการใช้
                                                    fit: BoxFit.cover, // ปรับขนาดรูปภาพให้พอดีกับขนาดของ Container
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              AutoSizeText(
                                                'Paid In',
                                                style: TextStyle(
                                                  color: theme.onBackground,
                                                  fontSize: 32,
                                                  fontFamily: 'Noto Sans Thai',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                maxLines: maxLines,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const Padin(
                                                paidType: "2",
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.325,
                                          padding: const EdgeInsets.all(24),
                                          decoration: ShapeDecoration(
                                            color: theme.background,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 1, color: theme.onBackground),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage('assets/hpaid-out 1.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              AutoSizeText(
                                                'Paid Out',
                                                style: TextStyle(
                                                  color: theme.onBackground,
                                                  fontSize: 32,
                                                  fontFamily: 'Noto Sans Thai',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                maxLines: maxLines,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const expense();
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.325,
                                          padding: const EdgeInsets.all(24),
                                          decoration: ShapeDecoration(
                                            color: theme.background,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 1, color: theme.onBackground),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/hExpense 1.png'), // เปลี่ยนเป็นตำแหน่งและชื่อไฟล์ภาพที่คุณต้องการใช้
                                                    fit: BoxFit.cover, // ปรับขนาดรูปภาพให้พอดีกับขนาดของ Container
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              AutoSizeText(
                                                'Expense',
                                                style: TextStyle(
                                                  color: theme.onBackground,
                                                  fontSize: 32,
                                                  fontFamily: 'Noto Sans Thai',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                maxLines: maxLines,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return opendrawer();
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.325,
                                          padding: const EdgeInsets.all(24),
                                          decoration: ShapeDecoration(
                                            color: theme.background,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(width: 1, color: theme.onBackground),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage('assets/hdrawer-open 2.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              AutoSizeText(
                                                'Open Drawer',
                                                style: TextStyle(
                                                  color: theme.onBackground,
                                                  fontSize: 32,
                                                  fontFamily: 'Noto Sans Thai',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                maxLines: maxLines,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
