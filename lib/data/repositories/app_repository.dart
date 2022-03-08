import 'dart:convert';

import 'package:hospital25/data/models/text_model.dart';
import 'package:hospital25/data/services/app_services.dart';

class AppRepository {
  final AppServices _apiServices;
  AppRepository(this._apiServices);

  Future<AppText> getAppText() async {
    try {
      final textJson = await _apiServices.getAppText();
      final appTextData = (json.decode(textJson) as Map<String, dynamic>)['acf']
          as Map<String, dynamic>;
      final appTextModel = AppText.fromMap(appTextData);
      return appTextModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAppCurrency() async {
    try {
      final currencyJson = await _apiServices.getAppCurrency();
      final currency = (json.decode(currencyJson)
          as Map<String, dynamic>)['value'] as String;
      return currency;
    } catch (e) {
      rethrow;
    }
  }
}
