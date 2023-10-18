import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kepler_pos/views/Drawer/widget/keyboard_drawer.dart';

import 'package:postgres/postgres.dart';
import 'package:provider/provider.dart';
//
import '../../../ViewModel/drawer_viewmodel.dart';
import '../../../models/drawer_model.dart';
import '../../../service/service.dart';
import '../dialog/paidin_success.dart';

class Padin extends StatefulWidget {
  const Padin({Key? key, required this.paidType}) : super(key: key);
  final String paidType;

  @override
  State<Padin> createState() => _PadinState();
}

class _PadinState extends State<Padin> {
  bool isTransactionComplete(List<Tender> lstTender, List<ReasonTender> lstReason) {
    for (var tender in lstTender) {
      if (tender.userInputQty > 0) {
        return true;
      }
    }
    for (var ReasonTender in lstReason) {
      if (ReasonTender.ReasonTenderId > 0) {
        return true;
      }
    }
    return false;
  }

  void navigateToDrawerPage() {
    Navigator.pop(context, dblTotalValues1);
  }

  List<FocusNode> focusNodes = [];
  ReasonTender? selectedReason;

  int textindex = 0;
  final List<String> titleList = ["Cash name", "Value", "Total"];
  final List<int> total = [0, 0, 0, 0, 0, 0, 0];

  void updateValueFromKeyboard(value) {
    if (value == "C") {
      textEditeController[textindex].text = "0";
    } else if (value == "0.00") {
      if (textEditeController[textindex].text == "0" || textEditeController[textindex].text == "") {
        textEditeController[textindex].text = "0";
      } else {
        textEditeController[textindex].text += "00";
      }
    } else if (value == "⌫") {
      textEditeController[textindex].text =
          textEditeController[textindex].text.substring(0, textEditeController[textindex].text.length - 1);
    } else if (value == ".") {
    } else {
      if (textEditeController[textindex].text == "0") {
        textEditeController[textindex].text = value;
      } else {
        textEditeController[textindex].text += value;
      }
    }

    updateTotalValues();
  }

  void updateTotalValues() {
    dblTotalValues1 = 0;

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
  }

  void doAlert(txt) {
    // ตรวจสอบว่ารายการครบถ้วนหรือไม่
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Incomplete Transaction'),
          content: Text(txt),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final List<Tender> lstTender = [];
  final List<ReasonTender> lstReason = [];
  DrawerViewModels page = DrawerViewModels();
  double dblTotalValues1 = 0;
  List<TextEditingController> textEditeController = [];
  @override
  void initState() {
    super.initState();
    lstReason.add(ReasonTender(1, 'Shopping costs', 0));
    lstReason.add(ReasonTender(2, 'Utility bills', 0));
    lstReason.add(ReasonTender(3, 'Material cost', 0));
    lstReason.add(ReasonTender(4, 'Other expense', 0));
    lstReason.add(ReasonTender(5, 'No Reason', 0));

    lstTender.add(Tender(1000, '1,000 B', 0, 0));
    lstTender.add(Tender(500, '500 B', 0, 0));
    lstTender.add(Tender(100, '100 B', 0, 0));
    lstTender.add(Tender(50, '50 B', 0, 0));
    lstTender.add(Tender(20, '20 B', 0, 0));
    lstTender.add(Tender(10, '10 B', 0, 0));
    lstTender.add(Tender(5, '5 B', 0, 0));

    for (int x = 0; x < lstTender.length; x++) {
      textEditeController.add(TextEditingController(text: ''));
      focusNodes.add(FocusNode());
    }
    focusNodes[0].requestFocus(); // Focus ตัวแรก (1000)

    // page.changePage(1);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print(textindex);
  }

  Future<bool> saveDataToPostgreSQL(List<Tender> lstTender) async {
    final service = Services();
    PostgreSQLConnection? connect = await service.connectToDatabase();
    try {
      // page.changePage(1);
      if (connect != null) {
        String query = "SELECT COALESCE(max(pid),0)+1 as newPID FROM drawer;";
        var resultMap = await connect.query(query);

        if (resultMap.length == 0) {
          print('Not found PID.');
          return false;
        }

        int? pid = 0;
        pid = int.tryParse(resultMap.first[0].toString());
        query =
            "INSERT INTO drawer (pid ,systemdate,type,cashvalue,reasonid ) VALUES (@value1, now(), @value2 , @value3,@value4)";

        int? intType = 0;
        intType = int.tryParse(widget.paidType);
        if (Type == 1) {
          // กรณี intType เป็น 1
          // ทำสิ่งที่ต้องการเมื่อ intType เป็น 1
        } else if (intType == 2) {
          // กรณี intType เป็น 2
          // ทำสิ่งที่ต้องการเมื่อ intType เป็น 2
        } else {
          // กรณี intType ไม่ใช่ทั้ง 1 และ 2
          // ทำสิ่งที่ต้องการเมื่อ intType ไม่ใช่ทั้ง 1 และ 2
        }

        final value = {
          'value1': pid,
          'value2': intType,
          'value3': dblTotalValues1 * (intType == 1 ? 1 : (-1)),
          'value4': selectedReason?.ReasonTenderId, //reasonID
        };
        // Execute the query with the specified values
        await connect.query(query, substitutionValues: value);

        // final int tenderlenght = lstTender.where((element) => element.userInputQty > 0).length ;

        for (var tender in lstTender.where((element) => element.userInputQty > 0)) {
          query =
              "INSERT INTO drawerdetail (pid ,tenderid,tenderqty,tendervalue ) VALUES (@value1, @value2 , @value3,@value4)";

          // Replace 'column1' and 'column2' with your actual table columns
          // Replace '@value1' and '@value2' with the values you want to insert

          final values = {
            'value1': pid,
            'value2': tender.TenderValue,
            'value3': tender.userInputQty,
            'value4': tender.calculatedTotalValue,
          };
          // Execute the query with the specified values
          await connect.query(query, substitutionValues: values);
        }
        print('Data inserted successfully');
        return true;
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await connect?.close();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final detailState = Provider.of<DrawerViewModels>(context);
    final double Defaultpadding = 24.00;
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    detailState.changePage(1);
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: screen.width * 0.02),
      title: Padding(
        padding: EdgeInsets.all(Defaultpadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.paidType == '1' ? 'Paid in' : 'Paid out',
              style: TextStyle(
                color: theme.primary,
                fontSize: 32,
                fontFamily: 'Noto Sans Thai',
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(); // กลับไปที่หน้า DrawerPage หน้าเดิมที่คุณเปิดอยู่
              },
              icon: Icon(Icons.close, color: theme.onPrimary),
            )
          ],
        ),
      ),
      content: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: ShapeDecoration(
                color: theme.onError,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: titleList
                        .map((e) => Text(
                              e,
                              style: TextStyle(
                                color: theme.onPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                        .toList(),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1.5,
                      height: MediaQuery.of(context).size.height * 0.48,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: lstTender.length,
                        separatorBuilder: (context, index) => const Divider(), // ตัวแยกในที่นี้เป็น Divider
                        itemBuilder: (context, index) {
                          final e = lstTender[index];
                          final TenderValue = e.TenderValue;
                          final TenderName = e.TenderName;
                          final userInputValue = e.userInputQty;
                          final calculatedTotalValue = e.calculatedTotalValue;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.11,
                                height: MediaQuery.of(context).size.height * 0.1,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: ShapeDecoration(
                                  color: theme.onError,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  spacing: 24,
                                  children: [
                                    AutoSizeText(
                                      TenderName,
                                      style: TextStyle(
                                        color: theme.primary,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // ],
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: ShapeDecoration(
                                        color: theme.background,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1, color: theme.onSurface),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: TextFormField(
                                        showCursor: true,
                                        readOnly: true,
                                        controller: textEditeController[index],
                                        focusNode: focusNodes[index],
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                            fontSize: 32,
                                            color: theme.onSurface, // สีของ hintText ที่คุณต้องการ
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 32, // ขนาดตัวเลขที่พิมพ์เข้าไป
                                          color: theme.primary, // สีของตัวเลขที่พิมพ์เข้าไป
                                        ),
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                                        // focusNode: _textFormFieldFocus,
                                        onTap: () {
                                          setState(() {
                                            textindex = index;
                                          });
                                        },
                                      ),
                                    ),
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Flexible(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  spacing: 24,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              runAlignment: WrapAlignment.center,
                                              spacing: 24,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                  height: MediaQuery.of(context).size.height * 0.1,
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                  decoration: ShapeDecoration(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(16),
                                                    ),
                                                  ),
                                                  child: AutoSizeText(
                                                    calculatedTotalValue.toString(),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontSize: 32, // ขนาดตัวเลขที่พิมพ์เข้าไป
                                                      color: theme.onBackground,
                                                    ),
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: theme.background,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: theme.onSurface),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: DropdownButton<ReasonTender>(
                    value: selectedReason,
                    onChanged: (newValue) {
                      setState(() {
                        selectedReason = newValue;
                      });
                    },
                    isExpanded: true,
                    underline: Container(),
                    hint: Text(
                      "Select Reason",
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: lstReason.map((reason) {
                      return DropdownMenuItem<ReasonTender>(
                        value: reason,
                        child: Text(
                          reason.ReasonTenderName,
                          style: TextStyle(
                            color: theme.primary,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: theme.background,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: theme.onSurface),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.paidType == '1' ? 'Paid in' : 'Paid out'} Amount',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 32, // ขนาดตัวเลขที่พิมพ์เข้าไป
                                color: theme.primary,
                                fontWeight: FontWeight.w500, // สีของตัวเลขที่พิมพ์เข้าไป
                              ),
                            ),
                            Text(
                              dblTotalValues1.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 32, // ขนาดตัวเลขที่พิมพ์เข้าไป
                                color: theme.primary,
                                fontWeight: FontWeight.w500,
                                // สีของตัวเลขที่พิมพ์เข้าไป
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Keyboard(
                  callbackB: (value) {
                    focusNodes[textindex].requestFocus();

                    setState(() {
                      updateValueFromKeyboard(value);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(Defaultpadding),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9166,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      key: const Key('clearButton'), // ตั้งชื่อ Key ให้กับปุ่ม "Clear all"
                      onTap: () {
                        for (int i = 0; i < textEditeController.length; i++) {
                          textEditeController[i].text = "0"; // รีเซ็ตค่าในตัวแปร textEditeController
                        }
                        setState(() {
                          for (var tender in lstTender) {
                            tender.calculatedTotalValue = 0; // รีเซ็ตค่าใน calculatedTotalValue
                          }
                        });
                        updateTotalValues(); // คำนวณค่ารวมใหม่
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        padding: const EdgeInsets.only(left: 32, right: 32, top: 13, bottom: 13),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: theme.onPrimary),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            AutoSizeText(
                              'Clear all',
                              style: TextStyle(
                                color: theme.primary,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            padding: const EdgeInsets.only(left: 32, right: 32, top: 13, bottom: 13),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: theme.onPrimary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Column(
                              children: [
                                AutoSizeText(
                                  'Cancel',
                                  style: TextStyle(
                                    color: theme.primary,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Ink(
                      decoration: ShapeDecoration(
                        color: theme.onBackground, // สีที่คุณต้องการให้เอฟเฟคเมื่อกด
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (selectedReason == null) {
                            doAlert('Please enter Reason.');
                            return;
                          }
                          if (dblTotalValues1 <= 0) {
                            doAlert('Please enter data for all values before saving.');
                            return;
                          }

                          if (await saveDataToPostgreSQL(lstTender)) {
                            detailState.updateCurrentCash();
                          }

                          Navigator.pop(context); // ปิด drawer

                          showDialog(
                            context: context,
                            builder: (context) {
                              return insuccess(paidType: widget.paidType);
                            },
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          padding: const EdgeInsets.only(left: 32, right: 32, top: 13, bottom: 13),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Column(
                            children: [
                              AutoSizeText(
                                'Save',
                                style: TextStyle(
                                  color: theme.background,
                                  fontSize: 25,
                                  fontFamily: 'Noto Sans Thai',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
