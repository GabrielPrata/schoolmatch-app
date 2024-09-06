import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<http.Response> login({required String username, required String password}) async {
    // String basicAuth = 'Basic ${base64Encode(utf8.encode('${ApiUrls.apiAuthPass}'))}';
    String basicAuth = 'Basic ${base64Encode(utf8.encode(''))}';
    final body = jsonEncode({
      "LOGIN": [
        {
          "USUARIO": username,
          "ALIAS": '',
          "SENHA": ''
          // "ALIAS": ApiUrls.alias,
          // "SENHA": Utils.criptografaSenha(password)
        }
      ]
    });
      final http.Response response = await http.post(
      // Uri.parse(ApiUrls.login),
      Uri.parse(''),
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
