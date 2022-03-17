import 'dart:async';
import 'dart:convert';

import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/languages/languages_cache.dart.dart';
import 'package:hospital25/core/utilities/hydrated_storage.dart';
import 'package:hospital25/core/utilities/oauth1.dart';
import 'package:http/http.dart' as http;

import '../models/customer_model.dart';



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
    final headers = {authorizationTxt: 'Bearer $token'};
    final response = await http.get(Uri.parse(url),headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }

  Future<String> deleteCart()async{
    const url = '$baseUrl/wc/store/cart/items';
    final token  = hydratedStorage.read(bearerTxt);
    final headers = {authorizationTxt: 'Bearer $token'};
    final response = await http.delete(Uri.parse(url),headers: headers);
    if (response.statusCode == 200) {
      return response.statusCode.toString();
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }

  Future<String> addToCart({required String? id,required String? quantity})async{
    const url = '$baseUrl/wc/store/cart/add-item';
    final token  = hydratedStorage.read(bearerTxt);
    final headers = {authorizationTxt: 'Bearer $token'};
    final response = await http.post(Uri.parse(url),headers: headers,
        body: {
          "id": id,
          "quantity": quantity
        });
    if (response.statusCode == 201) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }

  Future<String> checkOut({
  required Map<String,dynamic> billing,
  required Map<String,dynamic> shipping,
  required String paymentMethod,
  required String paymentTitle,
  required String customerId,
  required List<dynamic> cart,
  })async{
    const url = '$baseUrl/wc/v3/orders';
    final oAuth = getOAuthURL('POST', url);
    print("billing:$billing");
    print("shipping:$shipping");
    print("line_items: $cart");
    Map data ={
      "payment_method": paymentMethod,
      "payment_method_title": paymentTitle,
      "set_paid": true,
      "customer_id": customerId,
      "billing":billing,
      "shipping":shipping,
      "line_items": cart,
      "shipping_lines": [
        {
          "method_id": "flat_rate",
          "method_title": "Flat Rate",
          "total": "10.00"
        }
      ]
    };
    final body = jsonEncode(data);
    final response = await http.post(Uri.parse(oAuth),
    headers:  {
      contentTypeTxt: contentType,
    },
    body: body
    );
    if (response.statusCode == 201) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }

}
