import 'dart:convert';
import 'package:get_storage/get_storage.dart';
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

  //futuramente a lógica te obtenção de token será migrado para a API, pois assim nosso servidor fornecerá o token aos clients,
  //em vez de cada client gerar seu próprio token
  static Future<void> getAuthToken() async {
    String baseUrl = Constants.spotifyAuthUrl;

    var url = Uri.parse(baseUrl);
    var response = await http.post(url, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      'grant_type': Constants.spotifyGrantType,
      'client_id': Constants.spotifyClientId,
      'client_secret': Constants.spotifyClientSecret,
    });
    var jsonResponse = jsonDecode(response.body);
    String token = jsonResponse['access_token'];
    
    final GetStorage box = GetStorage();
    box.write("spotifyToken", token);
  }

  static Future<http.Response> findMusicByName({
    required String userSearch,
    required String jwtToken,
  }) async {
    String baseUrl = Constants.spotifyUrl + "search?q=" + userSearch;
    baseUrl += "&type=track&market=BR&limit=10&offset=0";

    var url = Uri.parse(baseUrl);

    var response =
        await http.get(url, headers: {'Authorization': "Bearer " + jwtToken});

    // print(response.body.toString());

    return response;
  }
}
