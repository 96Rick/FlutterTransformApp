// ignore_for_file: constant_identifier_names

class StringUtil {
//   // 邮箱
//   static const String regexEmail =
//       "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

// // 邮箱判断
//   static bool isEmail(String input) {
//     if (input.isEmpty) return false;
//     return RegExp(regexEmail).hasMatch(input);
//   }

  // 手机号
  static bool isChinaPhoneLegal(String str) {
    return RegExp(
            r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$")
        .hasMatch(str);
  }

  // 邮箱
  static bool isEmail(String str) {
    return RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
        .hasMatch(str);
  }

  static bool isPassword(String str) {
    return RegExp(r"^(?=.*[0-9].*)(?=.*[A-Z].*)(?=.*[a-z].*).{8,100}$")
        .hasMatch(str);
  }

  static bool isIdCard(String value) {
    return RegExp(r"\d{17}[\d|x]|\d{15}").hasMatch(value);
  }

  static String formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
      //小数点后有几位小数
      return (num.toStringAsFixed(postion)
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString());
    } else {
      return (num.toString()
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString());
    }
  }
}
