import 'package:easy_localization/easy_localization.dart';

String getShortNameOfDay(DateTime dateTime) {
  return DateFormat('E', 'en').format(dateTime);
}

bool checkShowingDate(String dateString) {
  try {
    // Parse ngày từ chuỗi
    final inputDate = DateTime.parse(dateString);

    // Lấy ngày hiện tại và đặt giờ, phút, giây về 0
    final currentDate = DateTime.now();
    final today = DateTime(currentDate.year, currentDate.month, currentDate.day);

    // So sánh ngày
    return inputDate.isBefore(today) || inputDate.isAtSameMomentAs(today);
  } catch (e) {
    // Nếu ngày không hợp lệ, trả về false
    return false;
  }
}
