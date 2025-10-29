
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:school_match/util/constants.dart';

final box = GetStorage();

class AccountService {
  static Future<http.Response> getUserData() async {
    try {
      final response = await http
          .get(Uri.parse('${Constants.userData}/${box.read('userId')}'), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer " + box.read("appToken"),
      });
      return response;
    } catch (e) {
      throw Exception("Erro de conexão com o servidor: $e");
    }
  }  static Future<http.Response> updateUserData(Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse(Constants.userData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + box.read("appToken"),
        },
        body: jsonEncode(data),
      );
      return response;
    } catch (e) {
      throw Exception("Erro de conexão com o servidor: $e");
    }
  }
}
