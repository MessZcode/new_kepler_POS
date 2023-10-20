import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kepler_pos/ViewModel/base_viewmodel.dart';
import 'package:kepler_pos/models/main_model.dart';
import 'package:postgres/postgres.dart';

import '../service/service.dart';

class ListTopsale {
  final String title;
  final int qty;
  final double value;

  ListTopsale({required this.title, required this.qty, required this.value});
}

class ProductId {
  final int id;

  ProductId({required this.id});
}

class ReportViewmodel extends ChangeNotifier {
  final service = Services();
  final baseviwmodel = BaseViewModel();
  double saleAmount = 0;
  double Discount = 0;
  double NetAmount = 0;
  double Vat = 0;
  double Cash = 0;
  double Paidin = 0;
  double Paidout = 0;
  double Cashindrawer = 0;
  double Credit = 0;
  bool fillterTop = true;
  bool fillterSort = true;
  List<ListTopsale> listtopSale = [];

  TextEditingController startdateTime_system = TextEditingController();
  TextEditingController endtdateTime_system = TextEditingController();
  TextEditingController startdateTime_top = TextEditingController();
  TextEditingController endtdateTime_top = TextEditingController();

  Future<void> fetchTablePayment() async {
    PostgreSQLConnection? connect = await service.connectToDatabase();

    try {
      if (connect != null) {
        String saleAmont = "SELECT SUM (totalamount) FROM orders WHERE billstatus = 'Complete'";
        var resultsaleAmont = await connect.query(saleAmont);
        String saleDiscount = "SELECT SUM (discountamount) FROM orders WHERE billstatus = 'Complete'";
        var resultsaleDiscount = await connect.query(saleDiscount);
        String saleCash = "SELECT SUM (paymentvalue) FROM orderpayments WHERE paymentid = 1";
        var resultsaleCash = await connect.query(saleCash);
        String saleCredit = "SELECT SUM (paymentvalue) FROM orderpayments WHERE paymentid = 2";
        var resultsaleCredit = await connect.query(saleCredit);
        String salePin = "SELECT SUM (cashvalue) FROM drawer WHERE type = 1";
        var resultsalePin = await connect.query(salePin);
        String salePout = "SELECT SUM (cashvalue) FROM drawer WHERE type = 2";
        var resultsalePout = await connect.query(salePout);
        String saleVat = "SELECT SUM (itemvat) FROM orderdetail";
        var resultsaleVat = await connect.query(saleVat);

        // if (resultsaleAmont.first[0] == null) {
        //   print('Not found SUM.');
        // } else {
        saleAmount = double.tryParse(resultsaleAmont.first[0])!;
        Cash = double.tryParse(resultsaleCash.first[0])!;
        Credit = double.tryParse(resultsaleCredit.first[0])!;
        Paidin = resultsalePin.first[0]!;
        Paidout = resultsalePout.first[0]!;
        Cashindrawer = (Cash + Paidin) + Paidout;
        Discount = double.tryParse(resultsaleDiscount.first[0])!;
        NetAmount = saleAmount - Discount!;
        Vat = double.tryParse(resultsaleVat.first[0])!;
        // }

        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await connect?.close();
    }
    // notifyListeners();
  }

  Future<void> fillterSystemsale() async {
    PostgreSQLConnection? connect = await service.connectToDatabase();
    String startDateTime = '${startdateTime_system.text} 00:00:00';
    String endDateTime = '${endtdateTime_system.text} 23:59:59';

    try {
      //---------------------------------------
      String saleAmont =
          "SELECT SUM (totalamount) FROM orders WHERE billstatus = 'Complete' AND orderdate BETWEEN '$startDateTime' AND '$endDateTime'";
      var resultsaleAmont = await connect?.query(saleAmont);

      if (resultsaleAmont?.first[0] != null) {
        saleAmount = double.tryParse(resultsaleAmont?.first[0])!;
      } else {
        saleAmount = 0;
      }
      //---------------------------------------
      String saleDiscount =
          "SELECT SUM (discountamount) FROM orders WHERE billstatus = 'Complete' AND orderdate BETWEEN '$startDateTime' AND '$endDateTime'";
      var resultsaleDiscount = await connect?.query(saleDiscount);

      if (resultsaleDiscount?.first[0] != null) {
        Discount = double.tryParse(resultsaleDiscount?.first[0])!;
      } else {
        Discount = 0;
      }
      //---------------------------------------
      NetAmount = saleAmount - Discount!;
      //---------------------------------------
      String saleVat =
          "SELECT SUM (vatamount) FROM orders WHERE billstatus = 'Complete' AND orderdate BETWEEN '$startDateTime' AND '$endDateTime'";
      var resultsaleVat = await connect?.query(saleVat);

      if (resultsaleVat?.first[0] != null) {
        Vat = double.tryParse(resultsaleVat?.first[0])!;
      } else {
        Vat = 0;
      }
      //---------------------------------------
      String saleCash =
          "SELECT SUM(paymentvalue) FROM orderpayments JOIN orders ON orderpayments.orderid = orders.orderid WHERE orderpayments.paymentid = 1 AND orders.orderdate BETWEEN '$startDateTime' AND '$endDateTime'";
      var resultsaleCash = await connect?.query(saleCash);

      if (resultsaleCash?.first[0] != null) {
        Cash = double.tryParse(resultsaleCash?.first[0])!;
      } else {
        Cash = 0;
      }
      //---------------------------------------
      String saleCredit =
          "SELECT SUM(paymentvalue) FROM orderpayments JOIN orders ON orderpayments.orderid = orders.orderid WHERE orderpayments.paymentid = 2 AND orders.orderdate BETWEEN '$startDateTime' AND '$endDateTime'";
      var resultsaleCredit = await connect?.query(saleCredit);

      if (resultsaleCredit?.first[0] != null) {
        Credit = double.tryParse(resultsaleCredit?.first[0])!;
      } else {
        Credit = 0;
      }
      //---------------------------------------
      String salePin =
          "SELECT SUM (cashvalue) FROM drawer WHERE type = 1 AND systemdate BETWEEN '$startDateTime' AND '$endDateTime'";

      var resultsalePin = await connect?.query(salePin);

      if (resultsalePin?.first[0] != null) {
        Paidin = double.tryParse(resultsalePin?.first[0])!;
      } else {
        Paidin = 0;
      }
      //---------------------------------------
      String salePout =
          "SELECT SUM (cashvalue) FROM drawer WHERE type = 2 AND systemdate BETWEEN '$startDateTime' AND '$endDateTime'";

      var resultsalePout = await connect?.query(salePout);

      if (resultsalePout?.first[0] != null) {
        Paidout = double.tryParse(resultsalePout?.first[0])!;
      } else {
        Paidout = 0;
      }
      //---------------------------------------
      Cashindrawer = (Cash + Paidin) + Paidout;
      //---------------------------------------
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    } finally {
      await connect?.close();
    }
  }

  Future<void> fethTopsale() async {
    PostgreSQLConnection? connect = await service.connectToDatabase();

    try {
      String topSale =
          "SELECT o.productid, p.productName, SUM(o.productqty) AS total_quantity, SUM(o.priceperunit) AS total_price FROM orderdetail o JOIN products p ON o.productid = p.productid GROUP BY o.productid, p.productName ORDER BY total_quantity DESC LIMIT 10";
      var resultsaletopSale = await connect?.query(topSale);

      // notifyListeners();
      listtopSale.clear();
      resultsaletopSale?.forEach((element) {
        listtopSale.add(ListTopsale(title: element[1], qty: element[2], value: double.parse(element[3])));
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      await connect?.close();
    }
    // notifyListeners();
  }

  Future<void> fillterTopsale() async {
    PostgreSQLConnection? connect = await service.connectToDatabase();
    String startDateTime = '${startdateTime_top.text} 00:00:00';
    String endDateTime = '${endtdateTime_top.text} 23:59:59';
    try {
      String topSale =
          "SELECT o.productid, p.productName, SUM(o.productqty) AS total_quantity, SUM(o.priceperunit) AS total_price FROM orderdetail o JOIN products p ON o.productid = p.productid AND EXISTS (SELECT 1 FROM orders WHERE orders.orderid = o.orderid AND orders.orderdate BETWEEN '$startDateTime' AND '$endDateTime') GROUP BY o.productid, p.productName ORDER BY total_quantity DESC LIMIT 10";
      var resultsaletopSale = await connect?.query(topSale);

      resultsaletopSale?.forEach((element) {
        listtopSale.add(ListTopsale(title: element[1], qty: element[2], value: double.parse(element[3])));
      });
      if (fillterSort == true) {
        listtopSale.sort((a, b) => a.title.compareTo(b.title));
      } else {
        listtopSale.sort((a, b) => b.title.compareTo(a.title));
      }
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      await connect?.close();
    }
  }

  void selectStartDate(DateTime date) {
    startdateTime_system.text = DateFormat('yyyy-MM-dd').format(date!);
    notifyListeners();
  }

  void selectEndDate(DateTime date) {
    endtdateTime_system.text = DateFormat('yyyy-MM-dd').format(date!);
    notifyListeners();
  }

  void selectStartDateT(DateTime date) {
    startdateTime_top.text = DateFormat('yyyy-MM-dd').format(date!);
    notifyListeners();
  }

  void selectEndDateT(DateTime date) {
    endtdateTime_top.text = DateFormat('yyyy-MM-dd').format(date!);
    notifyListeners();
  }

  void selecttop() {
    fillterTop = !fillterTop;
    notifyListeners();
  }

  void selectsort() {
    fillterSort = !fillterSort;
    notifyListeners();
  }
}
