import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});
  //
  @override
  Widget build(BuildContext context) {
    final maxLines = 1;
    final theme = Theme.of(context);
    // Color imageColor = Theme.of(context).focusColor;

    // Widget ColorizedImage() {
    //   return ColorFiltered(
    //     colorFilter:
    //         const ColorFilter.mode(Colors.transparent, BlendMode.clear),
    //     child: Stack(
    //       children: [
    //         Image.asset('assets/hpaid-out 1.png'),
    //         ColorFiltered(
    //           colorFilter: ColorFilter.mode(imageColor, BlendMode.srcATop),
    //           child: Image.asset('assets/hpaid-out 1.png'),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Container(
            child: SizedBox(
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
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Noto Sans Thai',
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
                                  color: theme.indicatorColor,
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
                                        color: theme.cardColor,
                                        fontSize: 32,
                                        fontFamily: 'Noto Sans Thai',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: maxLines,
                                    ),
                                    const SizedBox(height: 16),
                                    AutoSizeText(
                                      '0.00',
                                      style: TextStyle(
                                        color: theme.cardColor,
                                        fontSize: 40,
                                        fontFamily: 'Noto Sans Thai',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: maxLines,
                                    ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // showDialog(
                                                  //   context: context,
                                                  //   builder: (context) {
                                                  //     return Padin();
                                                  //   },
                                                  // );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.325,
                                                  padding:
                                                      const EdgeInsets.all(24),
                                                  decoration: ShapeDecoration(
                                                    color: theme.cardColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 1,
                                                          color: theme
                                                              .indicatorColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: const AssetImage(
                                                                    'assets/hpaid-in 1.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                                colorFilter:
                                                                    ColorFilter.mode(
                                                                        theme
                                                                            .indicatorColor,
                                                                        BlendMode
                                                                            .hue),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: const AssetImage(
                                                                    'assets/hpaid-in 1.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                                colorFilter: ColorFilter.mode(
                                                                    theme.cardColor,

                                                                    // Colors.deepOrangeAccent,
                                                                    BlendMode.xor),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      AutoSizeText(
                                                        'Paid In',
                                                        style: TextStyle(
                                                          color: theme
                                                              .indicatorColor,
                                                          fontSize: 32,
                                                          fontFamily:
                                                              'Noto Sans Thai',
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                                  // showDialog(
                                                  //   context: context,
                                                  //   builder: (context) {
                                                  //     return Padin();
                                                  //   },
                                                  // );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.325,
                                                  padding:
                                                      const EdgeInsets.all(24),
                                                  decoration: ShapeDecoration(
                                                    color: theme.cardColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 1,
                                                          color: theme
                                                              .indicatorColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: const AssetImage(
                                                                    'assets/hpaid-out 1.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                                colorFilter:
                                                                    ColorFilter.mode(
                                                                        theme
                                                                            .indicatorColor,
                                                                        BlendMode
                                                                            .hue),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: const AssetImage(
                                                                    'assets/hpaid-out 1.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                                colorFilter: ColorFilter.mode(
                                                                    theme.cardColor,

                                                                    // Colors.deepOrangeAccent,
                                                                    BlendMode.xor),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      AutoSizeText(
                                                        'Paid Out',
                                                        style: TextStyle(
                                                          color: theme
                                                              .indicatorColor,
                                                          fontSize: 32,
                                                          fontFamily:
                                                              'Noto Sans Thai',
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                                  // showDialog(
                                                  //   context: context,
                                                  //   builder: (context) {
                                                  //     return Padin();
                                                  //   },
                                                  // );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.325,
                                                  padding:
                                                      const EdgeInsets.all(24),
                                                  decoration: ShapeDecoration(
                                                    color: theme.cardColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 1,
                                                          color: theme
                                                              .indicatorColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: const AssetImage(
                                                                    'assets/hExpense 1.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                                colorFilter:
                                                                    ColorFilter.mode(
                                                                        theme
                                                                            .indicatorColor,
                                                                        BlendMode
                                                                            .hue),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: const AssetImage(
                                                                    'assets/hExpense 1.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                                colorFilter: ColorFilter.mode(
                                                                    theme.cardColor,

                                                                    // Colors.deepOrangeAccent,
                                                                    BlendMode.xor),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      AutoSizeText(
                                                        'Expense',
                                                        style: TextStyle(
                                                          color: theme
                                                              .indicatorColor,
                                                          fontSize: 32,
                                                          fontFamily:
                                                              'Noto Sans Thai',
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                                  // showDialog(
                                                  //   context: context,
                                                  //   builder: (context) {
                                                  //     return Padin();
                                                  //   },
                                                  // );
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.325,
                                                  padding:
                                                      const EdgeInsets.all(24),
                                                  decoration: ShapeDecoration(
                                                    color: theme.cardColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          width: 1,
                                                          color: theme
                                                              .indicatorColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: const AssetImage(
                                                                    'assets/hdrawer-open 2.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                                colorFilter:
                                                                    ColorFilter.mode(
                                                                        theme
                                                                            .indicatorColor,
                                                                        BlendMode
                                                                            .hue),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: const AssetImage(
                                                                    'assets/hdrawer-open 2.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                                colorFilter: ColorFilter.mode(
                                                                    theme.cardColor,

                                                                    // Colors.deepOrangeAccent,
                                                                    BlendMode.xor),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      AutoSizeText(
                                                        'Open Drawer',
                                                        style: TextStyle(
                                                          color: theme
                                                              .indicatorColor,
                                                          fontSize: 32,
                                                          fontFamily:
                                                              'Noto Sans Thai',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        maxLines: maxLines,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Container(
                                          //   height: 200,
                                          //   width: 200,
                                          //   color: Colors.deepOrangeAccent,
                                          //   child: Center(
                                          //     child: SvgPicture.asset(
                                          //       'assets/settings.svg',
                                          //     ),
                                          //   ),
                                          // )
                                          // Container(
                                          //   padding: EdgeInsets.all(20),
                                          //   color: Colors.white,
                                          //   child: ColorFiltered(
                                          //       colorFilter: ColorFilter.mode(
                                          //           imageColor, BlendMode.dst),
                                          //       child: Image.asset(
                                          //           'assets/hpaid-out 1.png')),
                                          // )
                                          // ColorizedImage(),
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
            ),
          ),
        ),
      ),
    );
  }
}
