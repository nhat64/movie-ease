import 'package:easy_localization/easy_localization.dart';

String getShortNameOfDay(DateTime dateTime) {
  return DateFormat('E', 'en').format(dateTime);
}
