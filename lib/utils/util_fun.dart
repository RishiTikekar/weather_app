class UtilFun {
  static bool isValidString(var str) {
    return str != null && str is String && str.isNotEmpty;
  }

  static bool isValidMap(var map) {
    return map != null && map is Map && map.isNotEmpty;
  }

  static bool isValidList(var list) {
    return list != null && list is List && list.isNotEmpty;
  }

  static String toCapitalize(String val) {
    return val.substring(0, 1).toUpperCase() + val.substring(1).toLowerCase();
  }

  ///output format 12/9/24 12:23 PM
  static String formatDatTo12Hour(DateTime dateTime) {
    dateTime = dateTime.toLocal();
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = 'AM';

    if (hour >= 12) {
      period = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
    }
    String dateFormat = "${dateTime.day}/${dateTime.month}/${dateTime.year}";

    String hourStr = hour.toString().padLeft(2, '0');
    String minuteStr = minute.toString().padLeft(2, '0');

    return '$dateFormat  $hourStr:$minuteStr $period';
  }
}
