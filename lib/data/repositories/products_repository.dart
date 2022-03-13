import 'dart:convert';

import 'package:hospital25/data/models/cart_model.dart';
import 'package:hospital25/data/models/products_list_model.dart';
import 'package:hospital25/data/models/text_model.dart';
import 'package:hospital25/data/services/app_services.dart';
import 'package:hospital25/data/services/products_services.dart';

class ProductsRepository{
  final ProductsServices _productsServices;

  ProductsRepository(this._productsServices);


  Future<List<ProductsListModel>> getAllProducts() async {
    try{
      final result = await _productsServices.getAllProducts();
      final productsJson = json.decode(result);
      final products = productsJson.map<ProductsListModel>((e) => ProductsListModel.fromJson(e)).toList();
      return products as List<ProductsListModel>;
    } catch(e){
      rethrow;
    }
  }

  Future<CartModel> getCart()async{
    try{
      final result = await _productsServices.getCart();
      final cartJson = json.decode(result);
      print("cart: ${cartJson['items'][0]['totals']}");
      final cart = CartModel.fromJson(cartJson);
      return cart;
    } catch(e){
      rethrow;
    }
  }

}
