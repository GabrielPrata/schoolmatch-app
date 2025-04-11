import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_match/domain/models/user_model.dart';
import 'package:school_match/util/constants.dart';

class AppDataService {
  static Future<http.Response> GetAllCourses() async {
    // String basicAuth = 'Basic ${base64Encode(utf8.encode('${ApiUrls.apiAuthPass}'))}';
    String basicAuth = 'Basic ${base64Encode(utf8.encode('${Constants.apiUser}:${Constants.apiPass}'))}';

    final http.Response response = await http.get(
      // Uri.parse(ApiUrls.login),
      Uri.parse('${Constants.apiUrl}${Constants.getAllCourses}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': basicAuth,
      },
      body: body,
    );
    // print('Response status, ${response.statusCode}');
    // print('Response body, ${response.body}');
    return response;
  }
}
