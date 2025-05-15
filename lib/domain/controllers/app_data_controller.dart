import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/services/app_data_service.dart';
import 'package:school_match/util/alerts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppDataController extends GetxController {
  var isLoading = false.obs;
  int userCouseId = 0;
  int courseDuration = 0;
  

  List<Map<String, dynamic>> appCourses = [];

  getAppCourses(BuildContext? context) async {
    try {
      final response = await AppDataService.getAppCourses();

      if (response.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(response);

      final updatedCourses = jsonList.map((item) {
        return {
          'id': item['courseId'],
          'nome': item['courseName'],
        };
      }).toList();

      appCourses = updatedCourses;
      return updatedCourses;
    } catch (e) {
      Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter os cursos! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
      return [];
    }
  }

  getCourseDuration(BuildContext context) async {
    try{
      final response =  await AppDataService.getCourseDuration(userCouseId);
      final json = jsonDecode(response);
      courseDuration = json['courseDuration'];

    } catch (e) {
       Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter a duração do curso! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
    }
    
    
  }

  setUserCourseId(int courseId) {
    userCouseId = courseId;
  }

}
