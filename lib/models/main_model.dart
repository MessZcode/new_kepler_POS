import 'dart:io';

class PagesModels {
  final int pageId;
  final String pageName;
  final String pageTitle;
  final String icon;

  PagesModels({
    required this.pageId,
    required this.pageName,
    required this.pageTitle,
    required this.icon,
  });
}

class SluGroup {
  final int sluGroupId;
  final String sluGroupName;
  // final int seq;
  SluGroup({required this.sluGroupId, required this.sluGroupName});
}

class SluItem {
  final int sluGroupId;
  final int itemSeq;
  final int productId;

  SluItem({required this.sluGroupId, required this.itemSeq, required this.productId});
}

class ProductModels {
  final int productId;
  final String productName;
  final double productPrice;
  final File? imageUrl;
  final int stockQTY;
  final bool isSuggest;
  final bool isPromotion;
  ProductModels({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.stockQTY,
    required this.isSuggest,
    required this.isPromotion,
  });

  factory ProductModels.initial(){
    return ProductModels(
      productId: 0, 
      productName: "", 
      productPrice: 0, 
      imageUrl: null,
      stockQTY: 0, 
      isSuggest: false, 
      isPromotion: false,
      );
  }
}

class CustomerModels {
  final int customerId;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final int membershiptypeId;

  CustomerModels({
    required this.customerId,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.membershiptypeId,
  });
  factory CustomerModels.initial(){
    return CustomerModels(
        customerId: 0,
        fname: "",
        lname: "",
        email: "",
        phone: "",
        membershiptypeId: 0,
    );
  }
}

class BillOrderModels {
  int orderId;
  DateTime orderDate;
  double totalAmount;
  double discountAmount;
  double vatAmount;
  double netAmount;
  String billStatus;
  int customerId;
  int userId;

  BillOrderModels(
      {required this.orderId,
      required this.orderDate,
      required this.totalAmount,
      required this.discountAmount,
      required this.vatAmount,
      required this.netAmount,
      required this.billStatus,
      required this.customerId,
      required this.userId});

  factory BillOrderModels.initial() {
    return BillOrderModels(
      orderId: 0,
      orderDate: DateTime.now(),
      totalAmount: 0,
      discountAmount: 0,
      vatAmount: 0,
      netAmount: 0,
      billStatus: "Open",
      customerId: 0,
      userId: 0,
    );
  }
}

class BillDetailModel {
  int orderId;
  final int orderDetailId;
  final int productId;
  final String productName;
  int productQty;
  final double priceperunit;
  double itemVat;
  double subTotal;
  double discount;

  BillDetailModel({
    required this.orderId,
    required this.orderDetailId,
    required this.productId,
    required this.productName,
    this.productQty = 1,
    required this.priceperunit,
    required this.itemVat,
    required this.subTotal,
    required this.discount,
  });
}

class ShowOrderPaymentSuccessModel {
  int orderId;
  int paymentSeq;
  int paymentId;
  double paymentValue;
  double paymentChange;
  String paymentString;

  ShowOrderPaymentSuccessModel({required this.orderId , required this.paymentSeq , required this.paymentId , required this.paymentValue , required this.paymentChange , required this.paymentString});

  factory ShowOrderPaymentSuccessModel.filterPaymentString({required ShowOrderPaymentSuccessModel showOrderPaymentValue}){
    String paymentString = "";
    switch(showOrderPaymentValue.paymentId){
      case 1:
        paymentString = "Cash";
        break;
      case 2:
        paymentString = "Credit Card";
        break;
      case 3:
        paymentString = "Merchant Wallet";
        break;
      case 4:
        paymentString = "AliPlay";
        break;
      case 5:
        paymentString = "WeChat Pay";
        break;
      case 6:
        paymentString = "THAI  QR  Payment";
        break;
      case 7:
        paymentString = "บัตรชาชน";
        break;
      default:
        paymentString = "";
    }
    return ShowOrderPaymentSuccessModel(
        orderId: showOrderPaymentValue.orderId,
        paymentSeq: showOrderPaymentValue.paymentSeq,
        paymentId: showOrderPaymentValue.paymentId,
        paymentValue: showOrderPaymentValue.paymentValue,
        paymentChange: showOrderPaymentValue.paymentChange,
        paymentString: paymentString,
    );
  }
}
