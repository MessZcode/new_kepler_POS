import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kepler_pos/service/service.dart';
import 'package:tuple/tuple.dart';
import '../models/main_model.dart';
import 'base_viewmodel.dart';

const _initialSelectOrderId = -1;

class BillViewModels extends ChangeNotifier {
  final services = Services();
  BaseViewModel? baseViewModel;
  bool selectBillHold = true;
  List<BillOrderModels> billOrder = [];
  List<BillDetailModel> billDetail = [];
  BillOrderModels selectOrder = BillOrderModels.initial();
  CustomerModels customer = CustomerModels.initial();
  int selectOrderById = _initialSelectOrderId;
  List<LineDataPrintModel> dataPrint = [];

  void setBaseViewModel(BaseViewModel baseViewModel) {
    this.baseViewModel = baseViewModel;
    notifyListeners();
  }

  void filterOrderByStatus() {
    billOrder.clear();
    if (baseViewModel != null && selectBillHold) {
      billOrder.addAll(baseViewModel!.billOrder
          .where((order) => order.billStatus == "Hold")
          .toList());
    } else if (baseViewModel != null && !selectBillHold) {
      billOrder.addAll(baseViewModel!.billOrder
          .where((order) => order.billStatus == "Complete")
          .toList());
    } else {
      print("baseViewModel is null");
    }
    notifyListeners();
  }

  void onTapSelectOrder(int orderId) {
    customer = CustomerModels.initial();
    if (selectOrderById == orderId) {
      selectOrderById = _initialSelectOrderId;
    } else {
      selectOrderById = orderId;
    }
    filterShowDetailByOrderId();
    notifyListeners();
  }

  void setSelectBill(bool state) {
    selectOrder = BillOrderModels.initial();
    billDetail.clear();
    selectOrderById = _initialSelectOrderId;
    selectBillHold = state;
    filterOrderByStatus();
    notifyListeners();
  }

  void filterShowDetailByOrderId() {
    billDetail.clear();
    if (selectOrderById != _initialSelectOrderId) {
      selectOrder = baseViewModel!.billOrder
          .firstWhere((billOrder) => billOrder.orderId == selectOrderById);
      int customerId = selectOrder.customerId;
      if (customerId != 0) {
        customer = baseViewModel!.customer
            .firstWhere((customer) => customer.customerId == customerId);
      }
      List<BillDetailModel> filteredList = baseViewModel!.billDetail
          .where((e) => e.orderId == selectOrderById)
          .toList();
      billDetail.addAll(filteredList);
      notifyListeners();
    }
  }

  void clearSelectOrderAndOrderDetail() {
    billDetail.clear();
    selectOrder = BillOrderModels.initial();
    selectOrderById = _initialSelectOrderId;
    notifyListeners();
  }

  Future<void> deleteAllBillHold() async {
    await services.deleteAllHoldBill();
    notifyListeners();
  }
  Future<void> printBill() async{
    BillOrderModels orders = BillOrderModels.initial();
    List<BillDetailModel> billDetail = [];
    billDetail.clear();
    dataPrint.clear();
    try{
      var result = await getBill();
      billDetail.addAll(result.item2);
      orders = result.item1;

      dataPrint.add(LineDataPrintModel(posLeft: null, posCenter: DataPrintModel.header(), posRight: null));
      dataPrint.add(LineDataPrintModel(posLeft: null, posCenter: DataPrintModel.banner(), posRight: null));
      dataPrint.add(LineDataPrintModel(
          posLeft: DataPrintModel(text: "Admin0001", isBold: false, isUnderLine: false, isItalic: false, size: 18),
          posCenter: null,
          posRight: DataPrintModel.printDate(),
      ));
      dataPrint.add(LineDataPrintModel(posLeft: null, posCenter: DataPrintModel.line(), posRight: null));
      for(var detail in billDetail){
        dataPrint.add(LineDataPrintModel(
            posLeft: DataPrintModel(text: "${detail.productQty} ${detail.productName}", isBold: false, isUnderLine: false, isItalic: false, size: 16),
            posCenter: null,
            posRight: DataPrintModel(text: detail.subTotal.toStringAsFixed(2), isBold: false, isUnderLine: false, isItalic: false, size: 16),
        ));
      }
      dataPrint.add(LineDataPrintModel(posLeft: null, posCenter: DataPrintModel.line(), posRight: null));
      dataPrint.add(LineDataPrintModel(
          posLeft: DataPrintModel(text:"sub Total", isBold: false, isUnderLine: false, isItalic: false, size: 16),
          posCenter: null,
          posRight: DataPrintModel(text: "20", isBold: false, isUnderLine: false, isItalic: false, size: 16)
      ));

    }catch(e){
      print("print Bill Faild");
    }
  }

  Future<Tuple2<BillOrderModels, List<BillDetailModel>>> getBill() async {
    BillOrderModels orders = BillOrderModels.initial();
    List<BillDetailModel> billDetail = [];

    debugPrint("OrderId : ${selectOrder.orderId}");
    var result = await services.checkOrder(orderId: selectOrder.orderId);
    // debugPrint(result);
    if (result != null && result.isNotEmpty) {
      print("Found orderId : ${selectOrder.orderId}");
      for (var detail in result) {
        billDetail.add(BillDetailModel(
            orderId: detail[9] as int,
            orderDetailId: detail[10] as int,
            productId: detail[11] as int,
            productName: detail[12] as String,
            productQty: detail[13] as int,
            priceperunit: double.parse(detail[14]),
            itemVat: double.parse(detail[15]),
            subTotal: double.parse(detail[16]),
            discount: double.parse(detail[17]),
        ));
        if(detail[10] as int == 1){
          orders.orderId = detail[0] as int;
          orders.orderDate = detail[1] as DateTime;
          orders.totalAmount = double.parse(detail[2]);
          orders.discountAmount = double.parse(detail[3]);
          orders.vatAmount = double.parse(detail[4]);
          orders.netAmount = double.parse(detail[5]);
          orders.billStatus = detail[6] as String;
          orders.customerId = detail[7] as int;
          orders.userId = detail[8] as int;
        }
      }
    }
    return Tuple2(orders, billDetail);
  }
}

class DataPrintModel {
  final String text;
  final bool isBold;
  final bool isUnderLine;
  final bool isItalic;
  final int size;
  DataPrintModel(
      {required this.text,
      required this.isBold,
      required this.isUnderLine,
      required this.isItalic,
      required this.size});

  factory DataPrintModel.eMerchant() {
    return DataPrintModel(
        text: "E-Merchant",
        isBold: true,
        isUnderLine: false,
        isItalic: false,
        size: 16);
  }
  factory DataPrintModel.printDate() {
    return DataPrintModel(
        text: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
        isBold: false,
        isUnderLine: false,
        isItalic: false,
        size: 16);
  }
  factory DataPrintModel.thank() {
    return DataPrintModel(
        text: "THANK YOU",
        isBold: false,
        isUnderLine: false,
        isItalic: false,
        size: 12);
  }
  factory DataPrintModel.header(){
    return DataPrintModel(text: "ห้อง 1230 38/1-3 ม.6 ถ.บางนา-ตราด \n ต.บางแก้ว อ.บางพลี จ.สมุทรปราการ 10540", isBold: false, isUnderLine: false, isItalic: false, size: 18);
  }

  factory DataPrintModel.banner(){
    return DataPrintModel(text: "ร้านตำตำ สาขาเมกา บางนา", isBold: false, isUnderLine: false, isItalic: false, size: 18);
  }
  factory DataPrintModel.line(){
    return DataPrintModel(text: "-----------------------------------------------", isBold: false, isUnderLine: false, isItalic: false, size: 18);
  }

}

class LineDataPrintModel {
  final DataPrintModel? posLeft;
  final DataPrintModel? posCenter;
  final DataPrintModel? posRight;

  LineDataPrintModel(
      {required this.posLeft, required this.posCenter, required this.posRight});

  factory LineDataPrintModel.print(
      {required DataPrintModel? posLeft,
      required DataPrintModel? posCenter,
      required DataPrintModel? posRight}) {
    return LineDataPrintModel(
        posLeft: posLeft, posCenter: posCenter, posRight: posRight);
  }
}
