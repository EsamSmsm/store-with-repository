import 'dart:convert';

import 'package:hospital25/data/models/address_model.dart';
import 'package:hospital25/data/models/cart_model.dart';
import 'package:hospital25/data/models/order_model.dart';
import 'package:hospital25/data/models/products_list_model.dart';
import 'package:hospital25/data/models/text_model.dart';
import 'package:hospital25/data/services/app_services.dart';
import 'package:hospital25/data/services/products_services.dart';

class ProductsRepository {
  final ProductsServices _productsServices;

  ProductsRepository(this._productsServices);

  Future<List<ProductsListModel>> getAllProducts() async {
    try {
      final result = await _productsServices.getAllProducts();
      final productsJson = json.decode(result);
      final products = productsJson
          .map<ProductsListModel>((e) => ProductsListModel.fromJson(e))
          .toList();
      return products as List<ProductsListModel>;
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> getCart() async {
    try {
      final result = await _productsServices.getCart();
      final cartJson = json.decode(result);
      final cart = CartModel.fromJson(cartJson);
      return cart;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteCart() async {
    try {
      final result = await _productsServices.deleteCart();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> addToCart(
      {required String? id, required String? quantity}) async {
    try {
      final result =
          await _productsServices.addToCart(id: id, quantity: quantity);
      final cartJson = json.decode(result);
      final cart = CartModel.fromJson(cartJson);
      return cart;
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderModel> checkOut(
      {
      required AddressModel billing,
      required AddressModel shipping,
      required String paymentMethod,
      required String paymentTitle,
      required String customerId,
      required List cart,
      }) async {
    final billingJson = billing.toMap(isBilling: true);
    final shippingJson = shipping.toMap(isBilling: false);
    final result = await _productsServices.checkOut(
        billing: billingJson,
        shipping: shippingJson,
        paymentMethod: paymentMethod,
        paymentTitle: paymentTitle,
        customerId: customerId,
        cart: cart,
        );
    final orderJson = json.decode(result);
    final orders = OrderModel.fromJson(orderJson);
    return orders;
  }
}
