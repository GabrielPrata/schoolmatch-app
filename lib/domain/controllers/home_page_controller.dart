import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/domain/models/appDataModels/course_model.dart';
import 'package:school_match/domain/models/appDataModels/interests_model.dart';
import 'package:school_match/domain/models/spotifyModels/music_adapter.dart';
import 'package:school_match/domain/models/user_about_model.dart';
import 'package:school_match/domain/models/homePageModels/user_like_model.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:school_match/domain/services/home_page_service.dart';
import 'package:school_match/util/alerts.dart';
// import 'package:rc_mineracao/domain/services/auth_service.dart';
// import 'package:rc_mineracao/ui/screens/home_page.dart';
// import 'package:rc_mineracao/ui/screens/login_page.dart';
// import 'package:rc_mineracao/ui/screens/select_subsidiary_page.dart';
// import 'package:rc_mineracao/util/alerts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../util/constants.dart';

class HomePageController extends GetxController {
  var errorText = false.obs;
  var isLoading = false.obs;

  List<UserProfileModel> profiles = [];
  List<String> imageStrings = [];

  sendUserLike(UserLikeModel data, BuildContext context) async {
    try {
      var response = await HomePageService.sendUserLike(data);

      print("Match Realizado!");
      print(response);
      // Navigator.push(
      //   context!,
      //   MaterialPageRoute(
      //     // builder: (_) => UserConfirmEmail(),
      //     builder: (_) => UserPassword(),
      //   ),
      // );
    } catch (e) {
      print("aaaaaaaaaaaaaaaaaaaaaaa");
      print(e.toString());
      Alerts.showErrorSnackBar(
          'Algo inesperado aconteceu! Tente novamente mais tarde ou contate o suporte.',
          context!);
    } finally {
      isLoading.trigger(false);
    }
  }

  loadBase64Images() async {
    final String data =
        await rootBundle.loadString('assets/imagens_mockadas.json');
    final jsonResult = jsonDecode(data) as Map<String, dynamic>;
    imageStrings = List<String>.from(jsonResult['imagens']);
  }

  getUsersDefault() async {
    try {
      final response = await HomePageService.getUsersDefault();

      if (response.statusCode != 200) {
        final body = jsonDecode(response.body);
        final message =
            body['message'] ?? "Erro ao buscar os dados ${response.statusCode}";
        throw Exception(message); // <-- exceção de negócio
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw Exception('Formato de resposta inesperado: esperado uma lista.');
      }

      // Limpa e carrega
      profiles
        ..clear()
        ..addAll(
          decoded.map((e) => UserProfileModel.fromJson(e as Map<String, dynamic>)),
        );

    } finally {
      isLoading.value = false;
    }
  }
}
