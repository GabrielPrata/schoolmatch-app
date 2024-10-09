import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_match/util/constants.dart';

class SpotifyService {
  // static Future<http.Response> login({required String username, required String password}) async {
  //   // String basicAuth = 'Basic ${base64Encode(utf8.encode('${ApiUrls.apiAuthPass}'))}';
  //   String basicAuth = 'Basic ${base64Encode(utf8.encode(''))}';
  //   final body = jsonEncode({
  //     "LOGIN": [
  //       {
  //         "USUARIO": username,
  //         "ALIAS": '',
  //         "SENHA": ''
  //         // "ALIAS": ApiUrls.alias,
  //         // "SENHA": Utils.criptografaSenha(password)
  //       }
  //     ]
  //   });
  //     final http.Response response = await http.post(
  //     // Uri.parse(ApiUrls.login),
  //     Uri.parse(''),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': basicAuth,
  //     },
  //     body: body,
  //   );
  //   // print('Response status, ${response.statusCode}');
  //   // print('Response body, ${response.body}');
  //   return response;
  // }

  static Future<http.Response> getAuthToken({
    required String userSearch,
  }) async {
    String baseUrl = Constants.spotifyAuthUrl;
    baseUrl +=
        "?grant_type=${Constants.spotifyGrantType}&client_id=${Constants.spotifyClientId}&client_secret=${Constants.spotifyClientSecret}";

    var url = Uri.parse(baseUrl);

    var response = await http.post(url);

    return response;
  }

  // static Future<http.Response> findMusicByName({
  //   required String userSearch,
  // }) async {
  //   String baseUrl = Constants.spotifyUrl + "search?q=" + userSearch;
  //   baseUrl += "&type=track&market=BR&limit=20&offset=0";
  //   // String basicAuth = 'Basic ${base64Encode(utf8.encode(''))}';
  //   final body = jsonEncode({
  //     "LOGIN": [
  //       {
  //         "USUARIO": username,
  //         "ALIAS": '',
  //         "SENHA": ''
  //         // "ALIAS": ApiUrls.alias,
  //         // "SENHA": Utils.criptografaSenha(password)
  //       }
  //     ]
  //   });
  //   final http.Response response = await http.post(
  //     // Uri.parse(ApiUrls.login),
  //     Uri.parse(''),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': basicAuth,
  //     },
  //     body: body,
  //   );
  //   // print('Response status, ${response.statusCode}');
  //   // print('Response body, ${response.body}');
  //   return response;
  // }
}
