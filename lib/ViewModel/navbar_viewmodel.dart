import 'package:flutter/cupertino.dart';

class NavbarViewModels extends ChangeNotifier {
  int selectPages = 1;
  int hoverPages = -1;
  int showPageSelect = 1;
  int previousPage = 1;
  void onHoverPages(hoverId) {
    if (hoverId == selectPages) {

    } else if (hoverId != hoverPages) {
      hoverPages = hoverId;
    } else {
      hoverPages = -1;
    }
  }

  void updateSelectPage(index) {
    previousPage = selectPages;
    selectPages = index;
    showPageSelect = index;
    if(index == 5){
      showPageSelect = previousPage;
    }
    notifyListeners();
  }
}
