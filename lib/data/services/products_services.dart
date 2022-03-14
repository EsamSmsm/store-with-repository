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
    final headers = {authorizationTxt: 'Bearer $token'};
    final response = await http.get(Uri.parse(url),headers: headers);
    if (response.statusCode == 200) {
      return response.body;
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

  Future<String> checkOut({required String? id,required String? quantity})async{
    const url = '$baseUrl/wc/v3/orders';
    final oAuth = getOAuthURL('GET', url);
    final response = await http.post(Uri.parse(oAuth),
    body: {
      "payment_method": "bacs",
      "payment_method_title": "Direct Bank Transfer",
      "set_paid": true,
      "customer_id": "2",
      "billing": {
        "first_name": "John",
        "last_name": "Doe",
        "address_1": "969 Market",
        "address_2": "",
        "city": "San Francisco",
        "state": "CA",
        "postcode": "94103",
        "country": "US",
        "email": "john.doe@example.com",
        "phone": "(555) 555-5555"
      },
      "shipping": {
        "first_name": "John",
        "last_name": "Doe",
        "address_1": "969 Market",
        "address_2": "",
        "city": "San Francisco",
        "state": "CA",
        "postcode": "94103",
        "country": "US"
      },
      "line_items": [
        {
          "product_id": 118,
          "quantity": 4,
          "subtotal": "400.00",
          "subtotal_tax": "0.00",
          "total": "400.00",
          "total_tax": "0.00"
        }

      ],
      "shipping_lines": [
        {
          "method_id": "flat_rate",
          "method_title": "Flat Rate",
          "total": "10.00"
        }
      ]
    });
    if (response.statusCode == 201) {
      return response.body;
    } else {
      print(response.reasonPhrase);
      throw response.body;
    }
  }

}
