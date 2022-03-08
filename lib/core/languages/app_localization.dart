import 'package:flutter/cupertino.dart';
import 'package:hospital25/core/languages/language_ar.dart';
import 'package:hospital25/core/languages/language_eng.dart';
import 'package:hospital25/core/languages/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageAr();
      default:
        return LanguageAr();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
