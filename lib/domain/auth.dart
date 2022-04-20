import 'dart:convert';

import 'package:case_study/domain/urls.dart';
import 'package:http/http.dart';

class FakeAuth {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await post(
      AppUrls.apiWith('login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      var data = await _getUser(2);
      return {
        'status': true,
        'user': {...data, 'token': json.decode(response.body)['token']}
      };
    } else {
      throw {'status': false, 'message': json.decode(response.body)['error']};
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await post(
      AppUrls.apiWith('register'),
      body: {'email': 'janet.weaver@reqres.in', 'password': password},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      var data = await _getUser(responseData['id']);
      return {...data, 'token': responseData['token']};
    } else {
      throw {'status': false, 'message': json.decode(response.body)['error']};
    }
  }

  Future<Map<String, dynamic>> _getUser(int id) async {
    final response = await get(AppUrls.apiWith('users/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw {'status': false, 'message': json.decode(response.body)['error']};
    }
  }
}
