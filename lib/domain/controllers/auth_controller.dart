import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:rc_mineracao/domain/services/auth_service.dart';
// import 'package:rc_mineracao/ui/screens/home_page.dart';
// import 'package:rc_mineracao/ui/screens/login_page.dart';
// import 'package:rc_mineracao/ui/screens/select_subsidiary_page.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../util/constants.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var errorText = false.obs;
  var isLoading = false.obs;

  validateUserLogin(String username, String password, BuildContext context) async {
    if (username.isEmpty || password.isEmpty) {
      errorText.value = true;
      return;
    } else {
      errorText.value = false;
    }

    isLoading.trigger(true);

    //Validando o usuário
    // final http.Response response = await AuthService.login(username: username, password: password);

    //trativa de erros
  //   if (response.statusCode == 401) {
  //     Alerts.showErrorSnackBar("Erro de autenticação com a API. Contate o suporte!", context);
  //     isLoading.trigger(false);
  //     return;
  //   }

  //   if(response.statusCode != 200) {
  //     Alerts.showErrorSnackBar("Erro ao conectar com a API. Código de erro: " + response.statusCode.toString(), context);
  //     isLoading.trigger(false);
  //     return;
  //   }

  //   var responseBody = jsonDecode(response.body);

  //   if(responseBody['CODIGO'] == 0 || responseBody['CODIGO'] == '0'){
  //     Alerts.showErrorSnackBar("Usuário incorreto!", context);
  //     isLoading.trigger(false);
  //     return;
  //   }


  //   if(responseBody['CODIGO'] == 2 || responseBody['CODIGO'] == '2'){
  //     Alerts.showErrorSnackBar("Senha incorreta!", context);
  //     isLoading.trigger(false);
  //     return;
  //   }
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(Constants.username, responseBody['NOME']);
  //   await prefs.setString(Constants.version, responseBody['VERSAO']);
  //   await prefs.setString(Constants.token, responseBody['TOKEN']);
  //   await prefs.setString(Constants.codUserObras, responseBody['CODUSUARIOOBRAS']);
  //   await prefs.setString(Constants.codUserMineracao, responseBody['CODUSUARIOMINERACAO']);
  //   await prefs.setString(Constants.codUserTotvs, responseBody['CODUSUARIOTOTVS']);
  //   await prefs.setString(Constants.solicitacao, responseBody['SOLICITACAO']);
  //   await prefs.setString(Constants.aprovacao, responseBody['APROVACAO']);
  //   await prefs.setString(Constants.financeiro, responseBody['FINANCEIRO']);
  //   await prefs.setString(Constants.relatorio, responseBody['RELATORIO']);
  //   await prefs.setString(Constants.aprovacaoNf, responseBody['APROVACAONF']);


  //   Alerts.showSuccessSnackBar("Autenticado com sucesso!", context);
  //   isLoading.trigger(false);
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => SelectSubsidiary(),
  //       ),
  //     );
  // }

  // getPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? userPrefs = prefs.getString(Constants.username);
  //   // String? token = prefs.getString(Constants.token);

  //   if(userPrefs == null) {
  //     Get.off(const LoginPage());
  //   } else {
  //     Get.off(const HomePage());
  //   }

  // }

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
