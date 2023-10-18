import 'package:flutter/material.dart';
import 'package:kepler_pos/models/main_model.dart';
import 'package:kepler_pos/service/service.dart';

class PaymentViewModels with ChangeNotifier {
  final services = Services();
  List<BillDetailModel> bilLDetail = [];

  BillOrderModels billOrder = BillOrderModels.initial();
  CustomerModels customer = CustomerModels.initial();
  PaymentStatusDetail paymentStatusDetail = PaymentStatusDetail.initial();
  TextEditingController textEditingController = TextEditingController();
  List<double> paymentSelectOptions = [20, 50, 100, 500, 1000];
  List<ShowOrderPaymentSuccessModel> showPaymentSuccess = [];
  void filterPayment(
      {required BillOrderModels billOrder,
      required List<BillDetailModel> billDetail,
      required CustomerModels customer}) {
    bilLDetail.clear();
    this.billOrder = BillOrderModels.initial();
    bilLDetail.addAll(billDetail);
    this.billOrder = billOrder;
    this.customer = customer;
    updatePaymentStatusDetail(paymentValue: 0);

    notifyListeners();
  }

  Future<void> updatePaymentStatusDetail({required double paymentValue}) async {
    paymentStatusDetail.orderId = billOrder.orderId;
    paymentStatusDetail.paymentAmount = billOrder.totalAmount;
    paymentStatusDetail.paymentValue = paymentValue;

    if (billOrder.orderId != 0) {
      paymentStatusDetail.paymentValueAmount = await services.checkPaymentByOrderId(order: billOrder);
    }
    // ยอดเงินที่ต้องจ่ายทั้งหมดคงเหลือ
    if (paymentStatusDetail.paymentAmount - paymentStatusDetail.paymentValueAmount < 0) {
      paymentStatusDetail.orderRemaining = 0;
    } else {
      paymentStatusDetail.orderRemaining = paymentStatusDetail.paymentAmount - paymentStatusDetail.paymentValueAmount;
    }

    //ถ้ายอดเงินคงเหลือที่ต้องจ่ายทั้งหมด < 0 = เงืนทอน
    //จำนวนเงินที่กรอก+จำนวนที่จ่ายไปแล้ว - จำนวนที่ต้องจ่ายทั้งหมด

    if ((paymentStatusDetail.paymentValue + paymentStatusDetail.paymentValueAmount) >
        paymentStatusDetail.paymentAmount) {
      paymentStatusDetail.changeAmount = (paymentStatusDetail.paymentValue + paymentStatusDetail.paymentValueAmount) -
          paymentStatusDetail.paymentAmount;
    } else {
      // paymentStatusDetail.changeAmount = 0;
    }
    await getShowPayment();
    notifyListeners();
  }

  void clearAllinPayment() {
    billOrder = BillOrderModels.initial();
    customer = CustomerModels.initial();
    paymentStatusDetail = PaymentStatusDetail.initial();
    textEditingController.clear();
    notifyListeners();
  }

  Future<void> getShowPayment() async {
    showPaymentSuccess.clear();
    try {
      if (billOrder.orderId != 0) {
        showPaymentSuccess.addAll(await services.getShowPaymentSuccess(order: billOrder));
      } else {
        showPaymentSuccess.clear();
      }
    } catch (e) {
      print("get showPayment Error");
    }
    notifyListeners();
  }

  void onTapKeyboardCash(String value) {
    if (value == 'C') {
      textEditingController.clear();
    } else if (value == '<-') {
      textEditingController.text.isEmpty
          ? null
          : textEditingController.text = textEditingController.text
              .replaceRange(textEditingController.text.length - 1, textEditingController.text.length, '');
    } else if (value == '.') {
      if (textEditingController.text.contains('.')) {
      } else {
        if (textEditingController.text.isNotEmpty) {
          textEditingController.text = textEditingController.text + value;
        }
      }
    } else if (value == '00') {
      if (textEditingController.text.contains('.0')) {
      } else {
        textEditingController.text = textEditingController.text + value;
      }
    } else {
      if (textEditingController.text.contains('.')) {
        int indexDot = textEditingController.text.indexOf(".");
        int index = textEditingController.text.length;
        if (index - indexDot > 2) {
        } else {
          textEditingController.text = textEditingController.text + value;
        }
      } else {
        textEditingController.text = textEditingController.text + value;
      }
    }
    if (textEditingController.text.isEmpty) {
      updatePaymentStatusDetail(paymentValue: 0);
    } else {
      updatePaymentStatusDetail(paymentValue: double.parse(textEditingController.text));
    }
    notifyListeners();
  }

  void onTapSelectAmount(double amount) {
    if (textEditingController.text.isEmpty) {
      textEditingController.text = amount.toStringAsFixed(0);
    } else {
      double number = double.parse(textEditingController.text) + amount;
      if (textEditingController.text.contains('.')) {
        if (textEditingController.text.contains('.0') || textEditingController.text.contains('.00')) {
          textEditingController.text = number.toStringAsFixed(0);
        } else {
          textEditingController.text = number.toStringAsFixed(2);
        }
      } else {
        textEditingController.text = number.toStringAsFixed(0);
      }
    }
    updatePaymentStatusDetail(paymentValue: double.parse(textEditingController.text));
    notifyListeners();
  }

  void updateSelectPaymentId({required int paymentId}) {
    paymentStatusDetail.paymentId = paymentId;
    notifyListeners();
  }

  Future<bool> onSubmitPayment({required PaymentStatusDetail paymentStatusDetail}) async {
    bool saveDatabaseStatus = false;
    try {
      saveDatabaseStatus = await services.addSubmitPayment(orderPayment: paymentStatusDetail);

      //if save database success >>
      if (saveDatabaseStatus) {
        paymentStatusDetail.paymentValueAmount += paymentStatusDetail.paymentValue;
      } else {
        return false;
      }
      //else save database failed
      //Don't to do

      bool checkPaymentSuccess = paymentStatusDetail.paymentValueAmount >= paymentStatusDetail.paymentAmount;
      if (checkPaymentSuccess) {
        paymentStatusDetail.paymentSuccess = true;
        paymentStatusDetail.orderRemaining = 0;
        debugPrint("Payment SuccessFully");
        await services.updateOrder(orderId: paymentStatusDetail.orderId, newStatus: "Complete");
      }
      this.paymentStatusDetail = paymentStatusDetail;
      // textEditingController.clear();

      notifyListeners();
      updatePaymentStatusDetail(paymentValue: 0);
      return true;
    } catch (e) {
      print("Payment Error : จ่ายเงินไม่สำเร็จ");
      return false;
    }
  }

  List<Paymentmodel> paymentOptions = [
    //ช่องทางการชำระเงิน
    Paymentmodel(
      image: 'cash1.png',
      text: 'Cash',
      id: 1,
      namepayment: 'cash',
      openDrawer: true,
    ),
    Paymentmodel(
      image: 'credit-card1.png',
      text: 'Credit\nCard',
      id: 2,
      namepayment: 'credit card',
      openDrawer: true,
    ),
    Paymentmodel(
      image: 'credit-card2.png',
      text: 'Merchant\nWallet',
      id: 3,
      namepayment: 'merchant wallet',
      openDrawer: false,
    ),
    Paymentmodel(
      image: 'credit-card3.png',
      text: '',
      id: 4,
      namepayment: 'alipay',
      openDrawer: false,
    ),
    Paymentmodel(
      image: 'credit-card4.png',
      text: '',
      id: 5,
      namepayment: 'wechat pay',
      openDrawer: false,
    ),
    Paymentmodel(
      image: 'credit-card5.png',
      text: '',
      id: 6,
      namepayment: 'thail qr payment',
      openDrawer: false,
    ),
    Paymentmodel(
      image: 'credit-card6.png',
      text: '',
      id: 7,
      namepayment: 'id card',
      openDrawer: false,
    ),
  ];
}

class Discount {
  final IconData icondiscount;
  final String text;
  // final Widget dialog;

  Discount(this.icondiscount, this.text);
}

class typePaymentModel {
  final int paymentId;
  final String title;
  final String iamges;

  typePaymentModel({
    required this.paymentId,
    required this.title,
    required this.iamges,
  });
}

class Paymentmodel {
  final int id;
  final String image;
  final String text;
  final String namepayment;
  final bool openDrawer;
  Paymentmodel({
    required this.id,
    required this.image,
    required this.text,
    required this.namepayment,
    required this.openDrawer,
  });
}

class OrderPaymentModel {
  int orderId;
  int paymentSeq;
  int paymentId;
  double paymentValue;
  double paymentChange;

  OrderPaymentModel({
    this.orderId = 0,
    this.paymentSeq = 0,
    this.paymentId = 0,
    this.paymentValue = 0.0,
    this.paymentChange = 0.0,
  });
}

class ShowPaymentModel {
  double paymentAmount;
  double orderRemaining;
  double changeAmount;
  ShowPaymentModel({
    required this.paymentAmount,
    required this.orderRemaining,
    required this.changeAmount,
  });
}

class PaymentStatusDetail {
  int orderId; //orderId
  int paymentSeq; // id payment 1.....
  int paymentId; // ช่องทางการชำระเงิน
  double paymentValueAmount; // ยอดที่จ่ายมาแล้วทั้งหมดเท่าไหร่
  double paymentAmount; // ยอดจ่ายทั้งหมด
  double orderRemaining; // orderRemaining ยอดเงินคงเหลือที่ต้องจ่าย
  double changeAmount; // เงินทอน
  double paymentValue; // เงืนที่จ่ายมา
  bool paymentSuccess;

  PaymentStatusDetail({
    required this.orderId,
    this.paymentSeq = 0,
    required this.paymentId,
    required this.paymentValueAmount,
    required this.paymentAmount,
    required this.orderRemaining,
    required this.changeAmount,
    required this.paymentValue,
    required this.paymentSuccess,
  });

  factory PaymentStatusDetail.initial() {
    return PaymentStatusDetail(
      orderId: 0,
      paymentId: 1,
      paymentValueAmount: 0,
      paymentAmount: 0,
      orderRemaining: 0,
      changeAmount: 0,
      paymentValue: 0,
      paymentSuccess: false,
    );
  }
}
