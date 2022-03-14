import 'dart:async';

import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/languages/languages_cache.dart.dart';
import 'package:hospital25/core/utilities/oauth1.dart';
import 'package:http/http.dart' as http;


class InformationServices{

  Future<String> getSlidesShow()async{
    final lang = getApiLanguage();
    const fields = 'id, title, content,_links';
    final query = '$lang&$fieldsTxt:$fields&_embed=wp:featuredmedia';
    final url = '$baseUrl/wp/v2/slideshow?$query';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }

  Future<String> getPaymentWays()async{
    const fields = 'id,title,description,enabled';
    const query = '$fieldsTxt:$fields';
    const url = '$baseUrl/wc/v3/payment_gateways?$query';
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
