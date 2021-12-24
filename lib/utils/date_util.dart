import 'package:intl/intl.dart';

class DateUtil {
  static int getExpirationTimeWith(int seconds) {
    return DateTime.now()
        .add(Duration(seconds: seconds - 120))
        .millisecondsSinceEpoch;
  }

  static bool isExpirationFromNow(int timeStamp) {
    DateTime expirationTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateTime.now().compareTo(expirationTime) >= 0;
  }

  static String getCurrentDateString() {
    return "${DateTime.now().year}/${DateTime.now().month}";
  }

  static String getCurrentDateWithYMDHMSToString() {
    var year = DateTime.now().year;
    var month = DateTime.now().month.toString().padLeft(2, "0");
    var day = DateTime.now().day.toString().padLeft(2, "0");
    var hour = DateTime.now().hour.toString().padLeft(2, "0");
    var minute = DateTime.now().minute.toString().padLeft(2, "0");
    var second = DateTime.now().second.toString().padLeft(2, "0");
    return "$year-$month-$day $hour:$minute:$second";
  }

  static String parseStringToFormateString(String str) {
    if (str == "") {
      return "";
    }
    DateTime time = DateTime.parse(str);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(time);
    return formattedDate;
  }
}
