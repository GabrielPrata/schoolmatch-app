import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/models/user_model.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class NewUserController extends GetxController {
  var isLoading = false.obs;

  int step = 0;

  //vou salvando os valores direto no objeto, acessando a controller no decorrer das páginas
  UserModel userModel = new UserModel();


  // Métodos de coleta dos dados dos formulários.
  //As validações devem ser feitas aqui.
  setUserEmail(String userEmail){
    userModel.email = userEmail;
  }

  setUserPassword(String userPassword){
    userModel.senha = userPassword;
  }

  setUserName(String userName){
    userModel.nome = userName;
  }

  setUserLastName(String userLastName){
    userModel.sobrenome = userLastName;
  }
}
