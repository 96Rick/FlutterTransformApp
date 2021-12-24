import 'dart:ui' show window;

class TTMSize {
  static double statusBarHeight = window.padding.top / window.devicePixelRatio;
  static double bottomNavHeight =
      window.padding.bottom / window.devicePixelRatio;
  static double screenHeight =
      window.physicalSize.height / window.devicePixelRatio;
  // static double screenHeight = MediaQuery.of(context).size.height;
  static double screenWidth =
      window.physicalSize.width / window.devicePixelRatio;
}
