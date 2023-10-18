import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import '../service/service.dart';

class DrawerViewModels extends ChangeNotifier {
  final service = Services();
  int page = 0;
  double currentCash = 0.0;

  void paymentcash(double payment) {
    currentCash += payment;
    notifyListeners();
  }

  void changePage(pages) {
    page = pages;
  }

  Future<void> updateCurrentCash() async {
    await QueryDatacashdrawer();
    notifyListeners();
  }

  Future<void> QueryDatacashdrawer() async {
    PostgreSQLConnection? connect = await service.connectToDatabase();

    try {
      // await connect?.open();
      // page.changePage(1);
      if (connect != null) {
        String query = "SELECT SUM (cashvalue) FROM drawer WHERE current_date = date(systemdate)";
        var resultMap = await connect.query(query);

        double? cashvalue = 0;
        if (resultMap.first[0] == null) {
          print('Not found SUM.');
        } else {
          cashvalue = double.tryParse(resultMap.first[0].toString());
        }

        currentCash = cashvalue!;
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await connect?.close();
    }
    notifyListeners();
  }
}
