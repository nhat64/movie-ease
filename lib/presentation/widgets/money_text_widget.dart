import 'package:flutter/material.dart';

class MoneyTextWidget extends StatelessWidget {
  const MoneyTextWidget({
    super.key,
    required this.money,
    this.style,
    this.unitStyle,
    this.unitRight = false,
  });

  final TextStyle? unitStyle;

  final TextStyle? style;

  final int money;

  final bool unitRight;

  String formatNumberStringWithDots(String numberStr) {
    StringBuffer formattedNumber = StringBuffer();

    int count = 0;

    // Duyệt qua chuỗi từ phải sang trái và thêm dấu . mỗi 3 số
    for (int i = numberStr.length - 1; i >= 0; i--) {
      formattedNumber.write(numberStr[i]);
      count++;
      if (count == 3 && i != 0) {
        formattedNumber.write('.');
        count = 0;
      }
    }

    // Đảo chuỗi lại để có định dạng đúng
    return formattedNumber.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    String moneyString = money.toString();

    String text = formatNumberStringWithDots(moneyString);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!unitRight)
          Text(
            'đ',
            style: unitStyle,
          ),
        if (!unitRight) const SizedBox(width: 4),
        Text.rich(
          style: style,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            text: text,
          ),
        ),
        if (unitRight)
          Text(
            'đ',
            style: unitStyle,
          ),
      ],
    );
  }
}
