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

class expense extends StatefulWidget {
  const expense({super.key});

  @override
  State<expense> createState() => _expenseState();
}

class _expenseState extends State<expense> {
  List<FocusNode> focusNodes = [];
  ReasonTender? selectedReason;

  // FocusNode _textFormFieldFocus = FocusNode();
  // int? selectedIndex;
  int textindex = 0;
  final List<String> titleList = ["Cash name", "Value", "Total"];

  void updateValueFromKeyboard(value) {
    if (value == "C") {
      textEditingController.text = "0";
    } else if (value == "0.00") {
      if (textEditingController.text == "0" || textEditingController.text == "") {
        textEditingController.text = "0";
      } else {
        textEditingController.text += "00";
      }
    } else if (value == "⌫") {
      textEditingController.text = textEditingController.text.substring(0, textEditingController.text.length - 1);
    } else if (value == ".") {
    } else {
      if (textEditingController.text == "0") {
        textEditingController.text = value;
      } else {
        textEditingController.text += value;
      }
    }

    // updateTotalValues();
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
  List<TextEditingController> textEditeController = [];

  TextEditingController textEditingController = TextEditingController();
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
    // focusNodes[0].requestFocus(); // Focus ตัวแรก (1000)
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    // print(textindex);
  }

  Future<bool> saveDataToPostgreSQL() async {
    final service = Services();
    PostgreSQLConnection? connect = await service.connectToDatabase();
    // final connection = PostgreSQLConnection(
    //   'localhost',
    //   5432,
    //   'Kepler_pos_Heart',
    //   username: 'postgres',
    //   password: '123456',
    // );

    try {
      // await connect?.open();
      page.changePage(3);
      if (connect != null) {
        String query = "SELECT COALESCE(max(pid),0)+1 as newPID FROM drawer;";
        var resultMap = await connect.query(query);

        if (resultMap.isEmpty) {
          print('Not found PID.');
          return false;
        }

        int? pid = 0;
        pid = int.tryParse(resultMap.first[0].toString());

        query =
            "INSERT INTO drawer (pid ,systemdate,type,cashvalue,reasonid ) VALUES (@value1, now(), @value2 , @value3,@value4)";

        int intType = 3;

        double? dblTotalValues1 = 0;
        dblTotalValues1 = double.tryParse(textEditingController.text);

        final value = {
          'value1': pid,
          'value2': intType,
          'value3': dblTotalValues1! * (-1),
          'value4': selectedReason?.ReasonTenderId, //reasonID
        };
        // Execute the query with the specified values
        await connect.query(query, substitutionValues: value);

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final detailState = Provider.of<DrawerViewModels>(context);
    final theme = Theme.of(context).colorScheme;
    detailState.changePage(3);
    final double Defaultpadding = 24.00;
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.all(Defaultpadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Expense",
              style: TextStyle(
                color: theme.primary,
                fontSize: 32,
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
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.42,
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
                        width: MediaQuery.of(context).size.width * 0.42,
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
                              "Paid In Amount",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 32, // ขนาดตัวเลขที่พิมพ์เข้าไป
                                color: theme.primary,
                                fontWeight: FontWeight.w500, // สีของตัวเลขที่พิมพ์เข้าไป
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: TextFormField(
                                showCursor: true,
                                readOnly: true,
                                controller: textEditingController,
                                focusNode: focusNodes[textindex],
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
                                    // textindex = index;
                                  });
                                },
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
                    // ff(value);
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
          child: Container(
            width: MediaQuery.of(context).size.width * 0.42,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
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

                          double? dblTotalValues1;
                          dblTotalValues1 = double.tryParse(textEditingController.text.toString());
                          if (dblTotalValues1 == null || dblTotalValues1 <= 0) {
                            doAlert('Please enter data for all values before saving.');
                            return;
                          }

                          if (await saveDataToPostgreSQL()) {
                            detailState.updateCurrentCash();
                          }
                          Navigator.pop(context); // ปิด drawer

                          showDialog(
                            context: context,
                            builder: (context) {
                              return insuccess(paidType: '3');
                            },
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: const EdgeInsets.only(left: 32, right: 32, top: 13, bottom: 13),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: theme.onBackground),
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
