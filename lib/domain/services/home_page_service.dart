import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_match/domain/models/homePageModels/user_like_model.dart';
import 'package:school_match/util/constants.dart';

class HomePageService {
  static Future<String> sendUserLike(UserLikeModel data) async {
    // Encode the UserModel to JSON
    final String body = jsonEncode(data.toJson());
    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse(Constants.verifyNewMatch),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    return response.body;
  }

  static Future<http.Response> getUsersDefault() async {
    try {
      final response = await http.post(
        Uri.parse(Constants.userLogin),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": , "password":}),
      );
      return response;
    } catch (e) {
      throw Exception("Erro de conexão com o servidor: $e");
    }
  }
}
