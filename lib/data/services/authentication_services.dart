import 'dart:convert';
import 'dart:developer';

import 'package:hospital25/core/constants/app_config.dart';
import 'package:hospital25/core/constants/constants.dart';
import 'package:hospital25/core/languages/languages_cache.dart.dart';
import 'package:hospital25/core/utilities/oauth1.dart';
import 'package:http/http.dart' as http;

class AuthenticationServices {
  Future<Map<String, dynamic>> registration({
    required String email,
    required String username,
    required String uid,
  }) async {
    final language = getApiLanguage();
    try {
      const headers = {'Content-Type': 'application/json'};
      final body = {'username': username, 'email': email, 'password': uid};

      final oAuthUrl = getOAuthURL('POST', '$baseUrl$registerEP?$language');

      final response = await http.post(
        Uri.parse(oAuthUrl),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        log(json.decode(response.body).toString());

        return json.decode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/jwt-auth/v1/token'),
        body: {'username': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final responseData = response.body;

        return responseData;
      } else {
        log(json.decode(response.body).toString());
        final error = (json.decode(response.body)
            as Map<String, dynamic>)['message'] as String;
        throw error;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String passwordOrUid,
    required String token,
  }) async {
    try {
      // final credentials =
      //     'Basic ${base64Encode(utf8.encode('$email:$passwordOrUid'))}';

      final headers = {authorizationTxt: 'Bearer $token'};

      final language = getApiLanguage();

      final response = await http.get(
        Uri.parse('$baseUrl$loginEP?$language'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        log(json.decode(response.body).toString());

        return json.decode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getCustomerData({required int id}) async {
    final language = getApiLanguage();
    try {
      final url = '$baseUrl$customerEP$id?$language';
      final oAuthUrl = getOAuthURL('GET', url);
      final response = await http.get(
        Uri.parse(oAuthUrl),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        log(json.decode(response.body).toString());

        return json.decode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePassword(String newPasswordJson, int id) async {
    try {
      final language = getApiLanguage();
      final headers = {contentTypeTxt: contentType};
      final url = '$baseUrl$customerEP$id?$language';
      final oAuthUrl = getOAuthURL('PUT', url);
      final response = await http.put(
        Uri.parse(oAuthUrl),
        headers: headers,
        body: newPasswordJson,
      );
      if (response.statusCode != 200) {
        log(json.decode(response.body).toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateCustomerData({
    required int id,
    required String customerJson,
    required String token,
  }) async {
    final language = getApiLanguage();
    try {
      final url = '$baseUrl$customerEP$id?$language';
      final oAuthUrl = getOAuthURL('PUT', url);
      final response = await http.put(
        Uri.parse(oAuthUrl),
        headers: {contentTypeTxt: contentType},
        body: customerJson,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        log(json.decode(response.body).toString());

        return json.decode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> searchForUserByMobileNumber(
      {required String mobileNumber}) async {
    final query = '$fieldsTxt:id,username&search=$mobileNumber';
    try {
      final url = '$baseUrl$customerEP?$query';

      final oauthUrl = getOAuthURL('GET', url);
      final response = await http.get(Uri.parse(oauthUrl));

      if (response.statusCode < 300) {
        return response.body;
      } else {
        log(json.decode(response.body).toString());
        throw response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getCustomerByEmail(
      {required String email}) async {
    try {
      final url = '$baseUrl$customerEP?email=$email';
      final oAuth1 = getOAuthURL('GET', url);
      log('OAuth url: $oAuth1 ');
      final response = await http.get(Uri.parse(oAuth1));
      if (response.statusCode == 200) {
        final Map<String, dynamic> customerData =
            (json.decode(response.body) as List<dynamic>).isNotEmpty
                ? (json.decode(response.body) as List<dynamic>)[0]
                    as Map<String, dynamic>
                : {};
        return customerData;
      } else {
        log(json.decode(response.body).toString());

        throw json.decode(response.body) as Map<String, dynamic>;
      }
    } catch (e) {
      rethrow;
    }
  }
}
