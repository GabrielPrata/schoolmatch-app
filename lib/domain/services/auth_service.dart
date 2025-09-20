import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:school_match/domain/models/user_model.dart';
import 'package:school_match/util/constants.dart';

class AuthService {
  static Future<http.Response> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.userLogin),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": username, "password": md5.convert(utf8.encode(password!)).toString()}),
      );

      return response;
    } catch (e) {
      throw Exception("Erro de conexão com o servidor: $e");
    }
  }

  static Future<http.Response> saveUserData({required UserModel data}) async {
    // Encode the UserModel to JSON
    final String body = jsonEncode(data.toJson());
    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse(Constants.userData),
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
      Uri.parse("${Constants.siteVerifyEmail}?userEmail=$userEmail"),
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
      Uri.parse("${Constants.verifyEmail}?userEmail=$userEmail"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}
