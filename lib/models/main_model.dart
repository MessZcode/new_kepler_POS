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

class CategoryModels {
  final int categoryId;
  final String categoryName;
  CategoryModels({required this.categoryId, required this.categoryName});
}

class productModels {
  final int productId;
  final String productName;
  final double productPrice;
  final String imageUrl;
  final int stockQTY;
  final bool isSuggest;
  final bool isPromotion;
  final int categoryId;
  productModels({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.stockQTY,
    required this.isSuggest,
    required this.isPromotion,
    required this.categoryId,
  });
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