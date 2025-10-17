import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:school_match/domain/models/homePageModels/user_like_model.dart';
import 'package:school_match/util/constants.dart';

final box = GetStorage();

class HomePageService {
  static Future<http.Response> sendUserLike(UserLikeModel data) async {
    // Encode the UserModel to JSON
    final String body = jsonEncode(data.toJson());
    // Make the POST request
    try {
      final http.Response response = await http.post(
        Uri.parse(Constants.verifyNewMatch),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + box.read("appToken"),
        },
        body: body,
      );
      return response;
    } catch (e) {
      throw Exception("Erro de conexão com o servidor: $e");
    }
  }

  static Future<http.Response> getUsersDefault() async {
    final String userLikeFindStr = box.read('userLikeFind');
    final List<dynamic> userLikeFind = jsonDecode(userLikeFindStr);
    final List<int> genderIds =
        userLikeFind.map((item) => item['genderId'] as int).toList();

    String body =
        jsonEncode({"userLikeFind": genderIds, "userId": box.read("userId")});
    try {
      final response = await http.post(Uri.parse(Constants.defaultSearch),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer " + box.read("appToken"),
          },
          body: body);
      return response;
    } catch (e) {
      throw Exception("Erro de conexão com o servidor: $e");
    }
  }

  static Future<http.Response> searchByCourseAndBlock(
      int courseId, int blockId) async {
    final String userLikeFindStr = box.read('userLikeFind');
    final List<dynamic> userLikeFind = jsonDecode(userLikeFindStr);
    final List<int> genderIds =
        userLikeFind.map((item) => item['genderId'] as int).toList();
    try {
      final response = await http.post(
        Uri.parse(Constants.searchByCourseAndBlock),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + box.read("appToken"),
        },
        body: jsonEncode({
          'courseId': courseId,
          'blockId': blockId,
          'preferences': {
            "userLikeFind": genderIds,
            "userId": box.read("userId")
          }
        }),
      );
      return response;
    } catch (e) {
      throw Exception("Erro de conexão com o servidor: $e");
    }
  }
}
