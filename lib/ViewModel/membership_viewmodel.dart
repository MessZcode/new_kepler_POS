import 'package:flutter/material.dart';
import 'package:kepler_pos/service/service.dart';

import '../../../models/main_model.dart';
//
// final CustomerModels _initialCustomer = CustomerModels(
//     customerId: 0,
//     fname: '',
//     lname: '',
//     email: '',
//     phone: '',
//     membershiptypeId: 0);

class MembershipViewmodel extends ChangeNotifier {
  final service = Services();
  CustomerModels customer = CustomerModels.initial();

  TextEditingController phoneStringController = TextEditingController();

  Future<CustomerModels?> checkCustomerByPhone(
      {required String phoneString}) async {
    try {
      CustomerModels? _profile = await service.checkCustomer(phoneString);
      if (_profile != null) {
        return _profile;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> checkCustomerByCustomerId({required int customerId}) async {
    try {
      CustomerModels? _profile =
          await service.checkCustomerByCustomerId(customerId);
      if (_profile != null) {
        customer = _profile;
      } else {
        return;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error checkCustomerId");
    }
  }

  bool saveCustomer({required CustomerModels newCustomer}) {
    try {
      customer = newCustomer;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void getDataToKeyboard(String phoneStringByOne) {
    var previousPhoneString = phoneStringController.text;
    if (phoneStringByOne == "<-" && phoneStringController.text.isNotEmpty) {
      phoneStringController.text = phoneStringController.text
          .substring(0, phoneStringController.text.length - 1);
      if (phoneStringController.text.isNotEmpty &&
          phoneStringController.text.lastIndexOf('-') ==
              phoneStringController.text.length - 1) {
        phoneStringController.text = phoneStringController.text
            .substring(0, phoneStringController.text.length - 1);
      }
    } else if (phoneStringController.text.length < 12 &&
        phoneStringByOne != "<-") {
      if (previousPhoneString.length == 3 || previousPhoneString.length == 7) {
        previousPhoneString += '-';
      }
      var newPhoneString = previousPhoneString + phoneStringByOne;
      phoneStringController.text = newPhoneString;
    }
    notifyListeners();
  }

  void clearPhoneStringController() {
    phoneStringController.clear();
    notifyListeners();
  }

  void clearCustomer() {
    customer = CustomerModels.initial();
    notifyListeners();
  }

  void setCustomerInHome({required CustomerModels customer}){
    this.customer = customer;
    notifyListeners();
  }
}

// class CustomerModel {
//   int customerId;
//   final String fname;
//   final String lname;
//   final String email;
//   final String phone;
//   final int membershiptypeId;
//
//   CustomerModel({
//     required this.customerId,
//     required this.fname,
//     required this.lname,
//     required this.email,
//     required this.phone,
//     required this.membershiptypeId,
//   });
// }
