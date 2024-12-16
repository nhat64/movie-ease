import 'package:intl/intl.dart';


String convertDateToYYYYMMDD(DateTime datetime) {
  return DateFormat('yyyy-MM-dd').format(datetime);
} 


// convert giây thành giờ, phút, giây định dạng HH:mm:ss
String convertSecondsToHMS(int seconds) {
  final Duration duration = Duration(seconds: seconds);
  final formatter = DateFormat('HH:mm:ss');
  String formattedTime = formatter.format(DateTime(0).add(duration));

  return formattedTime;
}

// chỉ sử dụng định dạng HH:mm:ss
// rút gọn thời gian bằng cách loại bỏ số 0 ở đầu
String simplifyFormattedTime(String timeString) {
  // Loại bỏ số 0 ở đầu của giờ, phút và giây nếu có thể
  List<String> parts = timeString.split(':');

  // Giờ
  if (parts[0].startsWith('0') && parts[0].length > 1) {
    parts[0] = parts[0].substring(1);
  }

  // Xử lý phút và giây (chỉ loại bỏ 0 nếu giờ là 0)
  if (parts[0] == '0' || parts[0] == '') {
    if (parts[1].startsWith('0') && parts[1].length > 1) {
      parts[1] = parts[1].substring(1);
    }
  }

  // Xử lý giây (chỉ loại bỏ 0 nếu giờ và phút là 0 hoặc rỗng)
  if ((parts[0] == '0' || parts[0] == '') && (parts[1] == '0' || parts[1] == '')) {
    if (parts[2].startsWith('0') && parts[2].length > 1) {
      parts[2] = parts[2].substring(1);
    }
  }

  return parts.join(':');
}
