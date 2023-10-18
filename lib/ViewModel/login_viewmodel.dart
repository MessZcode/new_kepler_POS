import 'package:flutter/cupertino.dart';

import '../../models/login_model.dart';

class Loginviewmodel extends ChangeNotifier {
  int textfeildnumber = 0;
  int selectLoginnumber = 0;
  int indexuser = 0;

  List<Usersuggest> user = [
    Usersuggest(username: 'Parida', usergroup: 'admin'),
    Usersuggest(username: 'Mongkol', usergroup: 'user'),
  ];
  final FocusNode focusNodeUser = FocusNode();
  final FocusNode focusNodePass = FocusNode();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void onTap_Keyboard(String value) {
    // user/pass
    if (selectLoginnumber == 0 && textfeildnumber == 1) {
      //username
      if (value == '<-') {
        if (username.text.isNotEmpty) {
          username.text = username.text.replaceRange(username.text.length - 1, username.text.length, '');
        }
      } else if (value == 'shift1' || value == 'shift2') {
      } else if (value == 'enter') {
      } else if (value == 'space') {
        username.text = '${username.text}-';
      } else {
        username.text = username.text + value;
      }
      focusNodeUser.requestFocus();
    }
    //pass
    else {
      // username.text = 'admin';
      if (value == '<-') {
        if (password.text.isNotEmpty) {
          password.text = password.text.replaceRange(password.text.length - 1, password.text.length, '');
        }
      } else if (value == 'shift1' || value == 'shift2') {
      } else if (value == 'enter') {
      } else if (value == 'space') {
        password.text = '${password.text}-';
      } else {
        password.text = password.text + value;
      }
      focusNodePass.requestFocus();
    }
    notifyListeners();
  }

  void onTap_Textfeild(int number) {
    textfeildnumber = number;
    notifyListeners();
  }

  void onTap_login() {
    username.text = '';
    password.text = '';
    notifyListeners();
  }

  void selectLogin(int number) {
    selectLoginnumber = number;
    notifyListeners();
  }

  void selectIndexUser(int number) {
    indexuser = number;
    notifyListeners();
  }
}
