import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:school_match/util/constants.dart';

final box = GetStorage();

class MatchService {
  static Future<http.Response> getUserMatches() async {
    try {
      print('${Constants.getUserMatches}/${box.read('userId')}');
      final response = await http
          .get(Uri.parse('${Constants.getUserMatches}/${box.read('userId')}'), headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer " + box.read("appToken"),
      });
      return response;
    } catch (e) {
      throw Exception("Erro de conexão com o servidor: $e");
    }
  }
}
