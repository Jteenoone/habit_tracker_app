
class DateFormatter {
  static String dateFormat(DateTime date) {
    int weekday = date.weekday;
    int month = date.month;
    int day = date.day;
    List<String> weekName = ['Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy', 'Chủ Nhật'];
    return '${weekName[weekday - 1]}, $day tháng $month';
  }

  static DateTime dateTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}