import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/domain/services/account_service.dart';
import 'package:school_match/util/functions.dart';

final box = GetStorage();

class UserProfileController extends GetxController {
  final AccountService _accountService = AccountService();

  var userProfile = UserProfileModel(userId: box.read('userId'), hasMusic: false.obs,).obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      final response = await AccountService.getUserData();

      if (response.statusCode != 200) {
        final msg = Functions.safeErrorMessage(response);
        throw Exception("Erro ao obter usuários: $msg");
      }

      final data = jsonDecode(response.body);
      userProfile.value = UserProfileModel.fromJson(data);
    } catch (e) {
      print("Erro em fetchUserData: $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
