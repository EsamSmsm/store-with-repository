import 'dart:async';

import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/languages/languages_cache.dart.dart';
import 'package:hospital25/core/utilities/oauth1.dart';
import 'package:http/http.dart' as http;

class AppServices {
  Future<String> getAppText() async {
    final lang = getApiLanguage();

    final url = '$baseUrl/acf/v3/options/options?$lang';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }

  Future<String> getAppCurrency() async {
    final lang = getApiLanguage();

    final url = '$baseUrl/wc/v3/settings/general/woocommerce_currency?$lang';
    final oAuth = getOAuthURL('GET', url);
    final response = await http.get(Uri.parse(oAuth));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }
}
