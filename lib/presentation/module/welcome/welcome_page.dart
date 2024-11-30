import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/constans/app_colors.dart';
import 'package:base_flutter/app/localization/locale_keys.g.dart';
import 'package:base_flutter/presentation/module/welcome/welcome_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends BaseScreen<WelcomeController> {
  const WelcomePage({super.key});
  

  @override
  Widget buildScreen(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: AppColors.yellowFCC434,
        child: Center(
          child: FadeTransition(
            opacity: controller.fadeAnimation,
            child: Text(
              LocaleKeys.hello,
              style: TextStyle(
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ).tr(),
          ),
        ),
      ),
    );
  }
}
