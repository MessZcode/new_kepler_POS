// ignore_for_file: public_member_api_docs, sort_constructors_first
class PrintBill {
  String header;
  String subHeader;
  DateTime createdDate;
  int number; // เลขที่ใบกำกับภาษี
  int chkNo;
  List<BillProduct> bill;
  double subTotal;
  double discount;
  double payAmount;
  double changeAmount;

  PrintBill({
    required this.header,
    required this.subHeader,
    required this.createdDate,
    required this.number,
    required this.chkNo,
    required this.bill,
    required this.subTotal,
    required this.discount,
    required this.payAmount,
    required this.changeAmount,
  });
}

class BillProduct {
  int productQTY;
  String productName;
  double price;

  BillProduct({
    required this.productQTY,
    required this.productName,
    required this.price,
  });
}
