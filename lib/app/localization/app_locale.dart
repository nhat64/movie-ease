class AppLocale {
  final String code;
  final String name;
  String? flag;
  String? countryCode;

  AppLocale({
    required this.code,
    required this.name,
    this.flag,
    this.countryCode,
  });

  static List<AppLocale> supportedLocales = [
    AppLocale(code: 'en', countryCode: 'US' , name: 'English'),
    AppLocale(code: 'vi', countryCode: 'VN', name: 'Tiếng Việt'),
  ];
}
