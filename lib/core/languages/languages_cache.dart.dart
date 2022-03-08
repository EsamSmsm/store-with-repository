import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/my_app.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<Locale> setLocale(String languageCode) async {
  await hydratedStorage.write(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

String apiLanguageCode = 'ar';

String getApiLanguage() {
  return 'lang=$apiLanguageCode';
}

void changeApiLanguageCode(String code) {
  apiLanguageCode = code;
}

Future<Locale> getLocale() async {
  late final String languageCode;
  final cachedLanguage =
      hydratedStorage.read(prefSelectedLanguageCode) as String?;
  if (cachedLanguage != null) {
    languageCode = cachedLanguage;
  } else {
    final locale = await Devicelocale.currentLocale;
    languageCode = locale?.split('_').first ?? 'ar';
  }
  apiLanguageCode = languageCode;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : const Locale('ar', '');
}

Future<void> changeLanguage(
    BuildContext context, String selectedLanguageCode) async {
  final _locale = await setLocale(selectedLanguageCode);
  changeApiLanguageCode(selectedLanguageCode);
  // ignore: use_build_context_synchronously
  MyApp.setLocale(context, _locale);
}
