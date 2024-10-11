import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:school_match/domain/controllers/spotify_controller.dart';
import 'package:school_match/util/constants.dart';

class SpotifyService {
  SpotifyController spotifyController = Get.put(SpotifyController());
  final GetStorage box = GetStorage();
 
  //futuramente a lógica te obtenção de token será migrado para a API, pois assim nosso servidor fornecerá o token aos clients,
  //em vez de cada client gerar seu próprio token
  Future<void> getAuthToken() async {
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
    
    box.write("spotifyToken", token);
  }

  Future<http.Response> findMusicByName({
    required String userSearch,
  }) async {
    String baseUrl = Constants.spotifyUrl + "search?q=" + userSearch;
    baseUrl += "&type=track&market=BR&limit=10&offset=0";

    var url = Uri.parse(baseUrl);

    var response =
        await http.get(url, headers: {'Authorization': "Bearer " + box.read("spotifyToken")});

    // print(response.body.toString());

    return response;
  }
}
