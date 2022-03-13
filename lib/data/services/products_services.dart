import 'dart:async';

import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/languages/languages_cache.dart.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/core/utilities/oauth1.dart';
import 'package:http/http.dart' as http;



class ProductsServices{

  Future<String> getAllProducts()async{
    final lang = getApiLanguage();
    const fields = 'id,name,description,price,regular_price,sale_price,categories,images';
    final query = '$lang&$fieldsTxt:$fields';
    final url = '$baseUrl/wc/v3/products?$query';
    final oAuth = getOAuthURL('GET', url);
    final response = await http.get(Uri.parse(oAuth));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }

  Future<String> getCart()async{
    const url = '$baseUrl/wc/store/cart';
    final token  = hydratedStorage.read(bearerTxt);
    print(token);
    final headers = {authorizationTxt: 'Bearer $token'};
    final response = await http.get(Uri.parse(url),headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }

}
