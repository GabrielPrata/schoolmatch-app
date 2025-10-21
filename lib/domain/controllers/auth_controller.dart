import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/services/auth_service.dart';

class AuthController extends GetxController {
  var errorText = false.obs;
  var isLoading = false.obs;
  final box = GetStorage();


  static logout() async {
    print("Saiu do sistema");
  }

  Future<void> validateUserLogin(
    String username,
    String password,
    BuildContext context,
  ) async {
    if (username.isEmpty || password.isEmpty) {
      throw Exception("Os dados de login não podem estar vazios!");
    }

    isLoading.value = true;
    try {
      final response =
          await AuthService.login(username: username, password: password);

      if (response.statusCode != 200) {
        final body = jsonDecode(response.body);
        final message = body['message'] ?? "Usuário ou senha inválidos.";
        throw Exception(message); // <-- exceção de negócio
      }

       final data = jsonDecode(response.body);

        await box.write('appToken', data["userToken"]);
        await box.write('userId', data["idUsuario"]);
        
        await box.write('userLikeFind', jsonEncode(data['usuarioPreferencia']).toString());


        
      // sucesso → parse e guarde o token
    } finally {
      isLoading.value = false;
    }





    // logout(BuildContext context) async {
    //   try {
    //     final prefs = await SharedPreferences.getInstance();
    //     await prefs.clear();

    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (_) => LoginPage(),
    //       ),
    //     );
    //   } catch (e) {
    //     print('$e deu erro');
    //   }
  }
}
