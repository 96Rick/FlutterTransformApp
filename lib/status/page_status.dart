import 'package:ttm/status/main_status_model.dart';

class PageStatus extends BaseStatus {
  void initPageStatus() {
    print("initPageStatus");
    homePageIndex = 0;
    notifyListeners();
  }

  void setHomePageIndex(int index) {
    homePageIndex = index;
    notifyListeners;
    print("home index" + homePageIndex.toString());
    notifyListeners();
  }
}
