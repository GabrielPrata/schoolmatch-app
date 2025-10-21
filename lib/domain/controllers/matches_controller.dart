import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/models/homePageModels/user_like_model.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:school_match/domain/services/home_page_service.dart';
import 'package:school_match/domain/services/match_service.dart';
import 'package:school_match/util/alerts.dart';
import 'package:school_match/util/functions.dart';
// import '../../util/constants.dart';

class MatchesController extends GetxController {
  var errorText = false.obs;
  var isLoading = false.obs;

  List<UserProfileModel> profiles = [];
  List<String> imageStrings = [];

  sendUserLike(UserLikeModel data, BuildContext context) async {
    try {
      final response = await HomePageService.sendUserLike(data);

      if (response.statusCode != 200 && response.statusCode != 204) {
        final msg = Functions.safeErrorMessage(response);
        throw Exception("Erro ao enviar a curtida $msg");
      }
      if (response.statusCode == 200) {
        Alerts.showSuccessSnackBar('Você tem um novo Match!', context);
      }
    } catch (e) {
      Alerts.showErrorSnackBar(
        e.toString().replaceAll('Exception: ', ''),
        context,
      );
    }
  }

  loadBase64Images() async {
    final String data =
        await rootBundle.loadString('assets/imagens_mockadas.json');
    final jsonResult = jsonDecode(data) as Map<String, dynamic>;
    imageStrings = List<String>.from(jsonResult['imagens']);
  }

  getUserMatches() async {
    try {
      final response = await MatchService.getUserMatches();

      if (response.statusCode != 200) {
        final msg = Functions.safeErrorMessage(response);

        throw Exception("Erro ao obter usuários: $msg");
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw Exception('Formato de resposta inesperado: esperado uma lista.');
      }

      // Limpa e carrega
      profiles
        ..clear()
        ..addAll(
          decoded
              .map((e) => UserProfileModel.fromJson(e as Map<String, dynamic>)),
        );
    } finally {}
  }
}
