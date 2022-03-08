import 'dart:convert';
import 'dart:developer';

import 'package:hospital25/data/models/customer_model.dart';
import 'package:hospital25/data/models/user_model.dart';
import 'package:hospital25/data/services/authentication_services.dart';

class CustomerRepository {
  final AuthenticationServices _apiServices;
  CustomerRepository(this._apiServices);

  Future<CustomerModel> getCustomer({required int id}) async {
    try {
      final customerData = await _apiServices.getCustomerData(
        id: id,
      );

      final customerModel = CustomerModel.fromMap(customerData);

      return customerModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerModel> updateCustomer({
    required int id,
    required CustomerModel customerModel,
    required String token,
  }) async {
    try {
      final customerJson = json.encode(customerModel.toMap());

      final updatedCustomerData = await _apiServices.updateCustomerData(
        id: id,
        customerJson: customerJson,
        token: token,
      );
      final updatedCustomerModel = CustomerModel.fromMap(updatedCustomerData);
      return updatedCustomerModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerModel> updateCustomerNameAndEmail({
    required int id,
    required String firstName,
    required String lastName,
    required String? email,
    required String token,
  }) async {
    try {
      final String customerJson;
      if (email != null && email.isNotEmpty) {
        customerJson = json.encode({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
        });
      } else {
        customerJson = json.encode({
          'first_name': firstName,
          'last_name': lastName,
        });
      }

      final updatedCustomerData = await _apiServices.updateCustomerData(
        id: id,
        customerJson: customerJson,
        token: token,
      );
      final updatedCustomerModel = CustomerModel.fromMap(updatedCustomerData);
      return updatedCustomerModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerModel> registerUser(
      String username, String email, String uid) async {
    try {
      final userData = await _apiServices.registration(
        email: email,
        uid: uid,
        username: username,
      );
      log(userData.toString());
      final customerModel = CustomerModel.fromMap(userData);
      return customerModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken(String email, String password) async {
    try {
      final response = await _apiServices.getToken(email, password);
      final jwt =
          (json.decode(response) as Map<String, dynamic>)['token'] as String;
      return jwt;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(
      String email, String passwordOrUID, String token) async {
    try {
      final userData = await _apiServices.login(
        email: email,
        passwordOrUid: passwordOrUID,
        token: token,
      );
      final userModel = UserModel.fromMap(
        userData,
        isLogin: true,
      );
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePassword(
    String newPassword,
    int id,
  ) async {
    try {
      final newPasswordJson = json.encode({
        'password': newPassword,
      });
      await _apiServices.updatePassword(newPasswordJson, id);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> searchForUserByMobileNumber(
      {required String mobileNumber}) async {
    try {
      final response = await _apiServices.searchForUserByMobileNumber(
          mobileNumber: mobileNumber);
      final userData = json.decode(response) as List;
      if (userData.isNotEmpty) {
        return (userData.first as Map<String, dynamic>)['id'] as int;
      } else {
        return -1;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerModel> getCustomerByEmail({required String email}) async {
    try {
      final customerData = await _apiServices.getCustomerByEmail(email: email);

      final customerModel = CustomerModel.fromMap(customerData);

      return customerModel;
    } catch (e) {
      rethrow;
    }
  }
}
