import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:kepler_pos/service/service.dart';

//
import 'base_viewmodel.dart';
import '../models/main_model.dart';
import 'membership_viewmodel.dart';

class HomeViewModels extends ChangeNotifier {
  BaseViewModel? baseViewModel;
  MembershipViewmodel? memberShipViewModel;

  bool statusTextFeild = false;

  final services = Services();

  List<int> selectCategoryId = [1];

  List<ProductModels> filterProducts = [];
  BillOrderModels billOrder = BillOrderModels.initial();
  List<BillDetailModel> billDetail = [];
  TextEditingController controller = TextEditingController();

  void getvaluekeyboard(String value) {
    if (value == '<-') {
      if (controller.text.isNotEmpty) {
        controller.text = controller.text.replaceRange(controller.text.length - 1, controller.text.length, '');
      }
    } else if (value == 'shift1' || value == 'shift2') {
    } else if (value == 'enter') {
    } else if (value == 'space') {
      controller.text = '${controller.text}-';
    } else {
      controller.text = controller.text + value;
    }
    searchProducts(controller.text);
    notifyListeners();
  }

  void tapStatusTextFeild(bool status) {
    statusTextFeild = status;
    notifyListeners();
  }

  void onTapProduct(int productId) {
    if (billDetail.where((billDetail) => billDetail.productId == productId).isEmpty) {
      billDetail.add(
        BillDetailModel(
          orderId: 0,
          orderDetailId: 0,
          productId: productId,
          productName: baseViewModel!.product.firstWhere((product) => product.productId == productId).productName,
          priceperunit: baseViewModel!.product.firstWhere((product) => product.productId == productId).productPrice,
          itemVat:
              baseViewModel!.product.firstWhere((product) => product.productId == productId).productPrice * (7 / 100),
          productQty: 1,
          subTotal: 0,
          discount: 0,
        ),
      );
    } else {
      billDetail.removeWhere((billDetail) => billDetail.productId == productId);
    }

    incrementBillDetail();
    notifyListeners();
  }

  void onPressedCategoryId(int categoryId) {
    if (categoryId != 1) {
      selectCategoryId.remove(1);
      if (!selectCategoryId.contains(categoryId)) {
        selectCategoryId.add(categoryId);
      } else {
        if (selectCategoryId.length == 1) {
          selectCategoryId.remove(categoryId);
          selectCategoryId.add(1);
        } else {
          selectCategoryId.remove(categoryId);
        }
      }
    } else {
      selectCategoryId.clear();
      selectCategoryId.add(categoryId);
    }
    filterProductByCategory();
    notifyListeners();
  }

  void clearBill() {
    billDetail.clear();
    notifyListeners();
  }

  void onTapAdd(int productId) {
    int stockQTY = baseViewModel!.product.firstWhere((product) => product.productId == productId).stockQTY;
    for (var item in billDetail) {
      if (item.productId == productId && item.productQty < stockQTY) {
        item.productQty++;
        break;
      }
    }
    incrementBillDetail();
    notifyListeners();
  }

  void onTapRemove(int productId) {
    for (var item in billDetail) {
      if (item.productId == productId && item.productQty != 1) {
        item.productQty--;
        break;
      }
    }
    incrementBillDetail();
    notifyListeners();
  }

  void incrementBillDetail() {
    double discount = 0.0;
    double totalAmount = 0.0;
    double discountAmount = 0.0;
    double vatAmount = 0.0;
    int customerId = 0;
    if (memberShipViewModel != null) {
      customerId = memberShipViewModel!.customer.customerId;
      if (memberShipViewModel!.customer.membershiptypeId == 1) {
        discount = 5.0;
      }
    }
    for (var item in billDetail) {
      double itemDiscount = 0;
      if (customerId != 0) {
        itemDiscount = ((item.priceperunit * item.productQty * discount) / 100);
      }
      //ของ OrderDetail
      item.discount = itemDiscount;
      item.subTotal = item.priceperunit * item.productQty - itemDiscount;
      item.itemVat = (item.priceperunit * item.productQty * 0.07);
      // ของ Order
      vatAmount += (item.priceperunit * item.productQty * 0.07);
      totalAmount += ((item.priceperunit) * item.productQty - itemDiscount);
      discountAmount += itemDiscount;
    }
    billOrder = BillOrderModels(
      orderId: billOrder.orderId,
      orderDate: DateTime.now(),
      totalAmount: totalAmount,
      discountAmount: discountAmount,
      vatAmount: vatAmount,
      netAmount: 0.0,
      billStatus: "open",
      customerId: customerId,
      userId: baseViewModel!.profile.userId,
    );
    notifyListeners();
  }

  void filterProductByCategory() {
    filterProducts.clear();
    if (baseViewModel == null) return;
    final allProducts = baseViewModel!.product;
    if (selectCategoryId.contains(1)) {
      filterProducts.addAll(allProducts);
    }
    if (selectCategoryId.contains(2)) {
      final suggestedProducts = allProducts.where(
        (product) =>
            product.isSuggest &&
            !filterProducts.any(
              (filter) => product.productId == filter.productId,
            ),
      );
      filterProducts.addAll(suggestedProducts);
    }
    if (selectCategoryId.contains(3)) {
      final promotionalProducts = allProducts.where(
        (product) =>
            product.isPromotion &&
            !filterProducts.any(
              (filter) => product.productId == filter.productId,
            ),
      );
      filterProducts.addAll(promotionalProducts);
    }
    final categoryProducts = allProducts.where(
      (product) =>
          selectCategoryId.contains(product.categoryId) &&
          !filterProducts.any(
            (filter) => product.productId == filter.productId,
          ),
    );
    filterProducts.addAll(categoryProducts);
  }

  void searchProducts(String query) {
    if (baseViewModel != null) {
      filterProducts.clear();
      filterProducts.addAll(
        baseViewModel!.product
            .where((product) =>
                product.productName.toLowerCase().contains(query.toLowerCase()) &&
                !filterProducts.any((filter) => product.productId == filter.productId))
            .toList(),
      );
    }
    notifyListeners();
  }

  Future<bool> onPressedHold({required List<BillDetailModel> billDetail, required BillOrderModels billOrders}) async {
    try {
      if (billOrders.orderId == 0) {
        //create order
        await services
            .createOrderAndAddBillDetail(order: billOrders, billDetails: billDetail, paymentStatus: "Hold")
            .then((status) async {
          if (status.status) {
            billOrder = BillOrderModels.initial();
          } else {
            return false;
          }
        });
        return true;
      } else if (billOrder.orderId != 0) {
        await services.updateAndAddAllBill(order: billOrders, billDetails: billDetail, paymentStatus: "Hold");
        billOrder = BillOrderModels.initial();
        //clear orderDetail by orderId
        //When clear success go to add all bill
        return true;
      }
      debugPrint("Hold bill Success");
    } catch (e) {
      debugPrint("Hold Bill Field");
    }
    return false;
  }

  Future<int> onPressedPayment({required BillOrderModels billOrder, required List<BillDetailModel> billDetail}) async {
    int orderID = 0;
    try {
      if (billOrder.orderId == 0) {
        await services
            .createOrderAndAddBillDetail(paymentStatus: "Payment", order: billOrder, billDetails: billDetail)
            .then((value) {
          if (value.status) {
            billOrder.orderId = value.orderId;
            orderID = value.orderId;
          }
        });
      } else {
        debugPrint("update PaymentStatus By orderId");
        await services.updateAndAddAllBill(order: billOrder, billDetails: billDetail, paymentStatus: "Payment");
        orderID = billOrder.orderId;
        notifyListeners();
      }
      return orderID;
    } catch (e) {
      debugPrint("Save Payment bill Error : $e");
      return orderID;
    }
  }

  void setBaseViewModel(BaseViewModel baseViewModel) {
    this.baseViewModel = baseViewModel;
    notifyListeners();
  }

  void setMemberShipViewModel(MembershipViewmodel memberShipViewModel) {
    this.memberShipViewModel = memberShipViewModel;
    notifyListeners();
  }

  void getRecallOrderAndBillDetail({required BillOrderModels billOrder, required List<BillDetailModel> billDetail}) {
    this.billOrder = billOrder;
    this.billDetail = billDetail;
    notifyListeners();
  }

  void clearAllinHome() {
    billOrder = BillOrderModels.initial();
    billDetail.clear();
    notifyListeners();
  }

  void setBillOrderAndBillDetail({required BillOrderModels billOrder, required List<BillDetailModel> billDetail}) {
    this.billOrder = BillOrderModels.initial();
    this.billDetail.clear();

    this.billDetail.addAll(billDetail);
    this.billOrder = billOrder;
    notifyListeners();
  }
}
