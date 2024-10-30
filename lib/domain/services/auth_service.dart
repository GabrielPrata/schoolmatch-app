import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_match/domain/models/user_model.dart';
import 'package:school_match/util/constants.dart';

class AuthService {
  static Future<http.Response> login(
      {required String username, required String password}) async {
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

  static Future<http.Response> saveUserData({required UserModel data}) async {
    // Encode the UserModel to JSON
    final String body = jsonEncode(data.toJson());
    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse(Constants.apiUrl + Constants.userData),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    return response;
  }

  static Future<http.Response> checkIfEmailIsVerified(String? userEmail) async {
    // Encode the UserModel to JSON
    // Make the POST request
    final http.Response response = await http.get(
      Uri.parse("${Constants.apiUrl}${Constants.userData}${Constants.verifyEmail}?userEmail=$userEmail"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  } 

  static Future<http.Response> sendEmailToVerify(String? userEmail) async {
    // Encode the UserModel to JSON
    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse("${Constants.apiUrl}${Constants.userData}${Constants.verifyEmail}?userEmail=$userEmail"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}
