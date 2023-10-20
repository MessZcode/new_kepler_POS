import 'package:flutter/material.dart';
import 'package:kepler_pos/service/api/api_Manager_String.dart';
import 'package:kepler_pos/service/connect_database.dart';
import 'package:kepler_pos/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/main_model.dart';

class Status {
  final bool isLogin;
  final bool loadData;

  Status({required this.isLogin, required this.loadData});
}

class UserModels {
  final int userId;
  final String fname;
  final String lname;
  final DateTime lastlogin;
  final String email;
  final String password;

  UserModels(
      {required this.userId,
      required this.fname,
      required this.lname,
      required this.lastlogin,
      required this.email,
      required this.password});
}

class BaseViewModel extends ChangeNotifier {
  final services = Services();
  final testServices = TestServices();
  final apiServices = ApiServices();
  UserProfile profile = UserProfile(userId: 0, fname: "", lname: "", email: "");

  List<PagesModels> pages = [];
  List<CategoryModels> category = [];
  List<ProductModels> product = [];
  List<BillOrderModels> billOrder = [];
  List<BillDetailModel> billDetail = [];
  List<CustomerModels> customer = [];
  List<UserModels> userslastlogin = [];

  String statusString = "";

  Future<Status> start() async {
    bool status = false;
    bool loadData = false;
    try {
      updateStatusString("checkDatabase");
      await testServices.checkDatabase();
      updateStatusString("getPages");
      await getPages();
      updateStatusString("getCategory");
      await getCategory();
      updateStatusString("getProducts");
      await getProducts();
      updateStatusString("getOrder");
      await getOrder();
      updateStatusString("getOrderDetail");
      await getOrderDetail();
      updateStatusString("getCustomer");
      await getCustomer();
      await getUsers();
      // await apiServices.getApi();
      updateStatusString("Get data success");
      loadData = true;

      status = await loadUser();
      notifyListeners();
      return Status(isLogin: status, loadData: loadData);
    } catch (e) {
      debugPrint("Error : $e");
      return Status(isLogin: status, loadData: loadData);
    }
  }

  void updateStatusString(String status) {
    statusString = status;
    // notifyListeners();
  }

  Future<bool> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    final previousUserId = prefs.getInt('user_id');
    final previousUserFname = prefs.getString('fname');
    final previousUserLname = prefs.getString('lname');
    final previousUserEmail = prefs.getString('email');

    if (previousUserFname != null && previousUserId != null && previousUserLname != null && previousUserEmail != null) {
      await prefs.setInt('user_id', previousUserId);
      await prefs.setString('fname', previousUserFname);
      await prefs.setString('lname', previousUserLname);
      await prefs.setString('email', previousUserEmail);
      profile = UserProfile(
          userId: previousUserId, fname: previousUserFname, lname: previousUserLname, email: previousUserEmail);
      return true;
    } else {
      return false;
    }
  }

  Future<void> getUsers() async {
    userslastlogin.clear();
    final result = await services.getUsers();
    List<UserModels> last = result!.map((lastLogin) {
      return UserModels(
        userId: lastLogin[0],
        fname: lastLogin[1],
        lname: lastLogin[2],
        lastlogin: lastLogin[3],
        email: lastLogin[4],
        password: lastLogin[5],
      );
    }).toList();
    userslastlogin.addAll(last);
    notifyListeners();
  }

  Future<bool> checkLogin(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId == null || userId != 0) {
      UserProfile? _user = await services.checkLogin(username, password);
      if (_user != null) {
        profile = UserProfile(userId: _user.userId, fname: _user.fname, lname: _user.lname, email: _user.email);
        prefs.setInt('user_id', _user.userId);
        prefs.setString('fname', _user.fname);
        prefs.setString('lname', _user.lname);
        prefs.setString('email', _user.email);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      profile = UserProfile(userId: 0, fname: "", lname: "", email: "");
      return true;
    } catch (e) {
      print("Error logout");
      return false;
    }
  }

  List<BillOrderModels>? checkOrder() {
    List<BillOrderModels> checkBillOrder = billOrder.where((billOrder) => billOrder.billStatus == "Payment").toList();
    if (checkBillOrder.isEmpty) {
      return null;
    }
    if (checkBillOrder.isNotEmpty && checkBillOrder.length > 1) {
      return null;
    }
    return checkBillOrder;
  }
  //-------------------------getData-----------------------------------------//

  Future<bool> getPages() async {
    pages.clear();
    try {
      var getPages = await services.fetchDataFromTable(TableString.pages);

      List<PagesModels> _pagesList = getPages!.map((row) {
        return PagesModels(
          pageId: row[0] as int,
          pageName: row[1] as String,
          pageTitle: row[2] as String,
          icon: row[3] as String,
        );
      }).toList();

      pages.addAll(_pagesList);

      notifyListeners();
      return true;
    } catch (e) {
      print("Error : $e");
      return false;
    }
  }

  Future<bool> getCategory() async {
    category.clear();
    try {
      var getCategory = await services.fetchDataFromTable(TableString.category);

      List<CategoryModels> _categoryList = getCategory!.map((category) {
        return CategoryModels(categoryId: category[0] as int, categoryName: category[1] as String);
      }).toList();

      category.addAll(_categoryList);
      notifyListeners();
      return true;
    } catch (e) {
      print("Error : $e");
      return false;
    }
  }

  Future<bool> getProducts() async {
    product.clear();
    try {
      var getProducts = await services.fetchDataFromTable(TableString.products);
      List<ProductModels> productlist = getProducts!.map((products) {
        return ProductModels(
          productId: products[0] as int,
          productName: products[1] as String,
          productPrice: double.parse(products[2]),
          imageUrl: products[3] as String,
          stockQTY: products[4] as int,
          isSuggest: products[5] as bool,
          isPromotion: products[6] as bool,
          categoryId: products[7] as int,
        );
      }).toList();
      product.addAll(productlist);
      notifyListeners();
      return true;
    } catch (e) {
      print("Error : $e");
      return false;
    }
  }

  Future<bool> getOrderDetail() async {
    billDetail.clear();
    try {
      var getOrderDetail = await services.fetchDataFromTable(TableString.orderdetails);
      if (getOrderDetail != null) {
        List<BillDetailModel> detailModel = getOrderDetail.map((orderDetail) {
          return BillDetailModel(
              orderId: orderDetail[0] as int,
              orderDetailId: orderDetail[1] as int,
              productId: orderDetail[2] as int,
              productName: orderDetail[3] as String,
              productQty: orderDetail[4] as int,
              priceperunit: double.parse(orderDetail[5]),
              itemVat: double.parse(orderDetail[6]),
              subTotal: double.parse(orderDetail[7]),
              discount: double.parse(orderDetail[8]));
        }).toList();
        billDetail.addAll(detailModel);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("getOrderDetail Error");
      return false;
    }
  }

  Future<bool> getOrder() async {
    billOrder.clear();
    try {
      var getOrder = await services.fetchDataFromTable(TableString.orders);
      List<BillOrderModels> model = getOrder!.map((order) {
        return BillOrderModels(
            orderId: order[0] as int,
            orderDate: order[1] as DateTime,
            totalAmount: double.parse(order[2] as String),
            discountAmount: double.parse(order[3] as String),
            vatAmount: double.parse(order[4] as String),
            netAmount: double.parse(order[5] as String),
            billStatus: order[6] as String,
            customerId: order[7] as int,
            userId: order[8] as int);
      }).toList();
      billOrder.addAll(model);
      notifyListeners();
      return true;
    } catch (e) {
      print("Error getOrder");
      return false;
    }
  }

  Future<bool> getCustomer() async {
    customer.clear();
    try {
      var getCustomer = await services.fetchDataFromTable(TableString.customers);
      List<CustomerModels> model = getCustomer!.map((customer) {
        return CustomerModels(
          customerId: customer[0] as int,
          fname: customer[1] as String,
          lname: customer[2] as String,
          email: customer[3] as String,
          phone: customer[4] as String,
          membershiptypeId: customer[5] as int,
        );
      }).toList();
      customer.addAll(model);
      notifyListeners();
      return true;
    } catch (e) {
      print("Error getCustomer");
      return false;
    }
  }
}
