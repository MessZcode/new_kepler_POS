class Tender {
  final int TenderValue;
  final String TenderName;
  late int userInputQty;
  double
      calculatedTotalValue; // ตัวแปรที่ใช้เก็บผลคูณของ TenderValue กับ userInputValue

  Tender(
    this.TenderValue,
    this.TenderName,
    this.userInputQty,
    this.calculatedTotalValue, // เพิ่มตัวแปรนี้
  );
}

class ReasonTender {
  final int ReasonTenderId;
  final String ReasonTenderName;
  double amount;
  ReasonTender(
    this.ReasonTenderId,
    this.ReasonTenderName,
    this.amount,
  );
}

class FunctionDrawer {
  double cashvalue;
  final int type;

  FunctionDrawer(
    this.cashvalue,
    this.type,
  );
}
