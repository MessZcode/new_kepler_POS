import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import '../../../service/service.dart';
//
class opendrawer extends StatefulWidget {
  @override
  _OpendrawerState createState() => _OpendrawerState();
}

class _OpendrawerState extends State<opendrawer> {
  bool isDataSaved = false;

  Future<void> saveDataToPostgreSQL() async {
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
      if (connect != null) {
        String query = "SELECT COALESCE(max(pid),0)+1 as newPID FROM drawer;";
        var resultMap = await connect.query(query);

        if (resultMap.isEmpty) {
          print('Not found PID.');
          return;
        }

        int? pid = 0;
        pid = int.tryParse(resultMap.first[0].toString());

        query =
            "INSERT INTO drawer (pid ,systemdate,type,cashvalue,reasonid ) VALUES (@value1, now(), @value2 , @value3,@value4)";

        int intType = 4;

        final value = {
          'value1': pid,
          'value2': intType,
          'value3': 0,
          'value4': "", //reasonID
        };
        // Execute the query with the specified values
        if ((await connect.execute(query, substitutionValues: value)) > 0) {}
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await connect?.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    bool isOpenedCashDrawer = true;
    if (isOpenedCashDrawer) {
      saveDataToPostgreSQL();
    }

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.67,
        height: MediaQuery.of(context).size.height * 1.0,
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/hdrawer-open 2.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        // width: 60,
                        // height: 60,
                        child: FutureBuilder<void>(
                      future: Future.delayed(const Duration(
                          seconds: 1)), // เรียกใช้ฟังก์ชัน saveDataToPostgreSQL
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CupertinoActivityIndicator(
                            radius: 30,
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 60,
                          );
                        }
                      },
                    )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        'Open drawer!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFD6412),
                          fontSize: 48,
                          fontFamily: 'Noto Sans Thai',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
