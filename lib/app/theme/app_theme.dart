import 'package:base_flutter/app/constans/app_strings.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // cần thêm các thuộc tính cần thiết cho theme để phục vụ đổi dark/light theme
  // các tài nguyên về màu lấy ở AppColors, cho vào các phần cần thiết như colorScheme, primary, seconds, ...
  // link về cách dùng màu https://medium.com/@nikhithsunil/theme-your-flutter-app-a-guide-to-themedata-and-colorscheme-d8bca920a6b5
  // các tài nguyên về font chữ thì thêm vào asset hoặc dùng google font
  // text thì ThemeData chỉ thêm AppTextTheme cho có thôi chứ chủ yếu dùng trong AppTextStyles cho linh hoạt

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        fontFamily: AppStrings.fontName,
        scaffoldBackgroundColor: Colors.black,
        shadowColor: Colors.grey,
        visualDensity: VisualDensity.standard,
        dividerColor: Colors.grey,
      );

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: AppStrings.fontName,
        scaffoldBackgroundColor: Colors.white,
        shadowColor: Colors.grey,
        visualDensity: VisualDensity.standard,
        dividerColor: Colors.grey,
      );
}
