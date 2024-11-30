import 'package:base_flutter/app/localization/app_locale.dart';
import 'package:base_flutter/app/theme/app_theme.dart';
import 'package:base_flutter/app_provider.dart';
import 'package:base_flutter/di.dart';
import 'package:base_flutter/presentation/routes/route_pages.dart';
import 'package:base_flutter/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // dependency injection
  await configureDependencies();

  configLoading();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: EasyLocalization(
        supportedLocales: AppLocale.supportedLocales.map((e) => Locale(e.code, e.countryCode)).toList(),
        path: 'assets/translations',
        startLocale: const Locale('vi', 'VN'),
        child: const MyBaseApp(),
      ),
    ),
  );
}

class MyBaseApp extends StatelessWidget {
  const MyBaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.find<AppProvider>().rootNavigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Base flutter',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: context.watch<ThemeProvider>().mode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: AppPages.initial,
      getPages: AppPages.appRoutes,
      defaultTransition: Transition.cupertino,
      builder: EasyLoading.init(
        builder: ((context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: widget!,
          );
        }),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.chasingDots
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..backgroundColor = Colors.transparent
    ..boxShadow = <BoxShadow>[]
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
