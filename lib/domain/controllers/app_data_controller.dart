import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/domain/models/appDataModels/course_model.dart';
import 'package:school_match/domain/services/app_data_service.dart';
import 'package:school_match/util/alerts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppDataController extends GetxController {
  var isLoading = false.obs;
  int userCouseId = 0;
  int courseDuration = 0;

  List<CourseModel> appCourses = [];
  List<BlockModel> appMainBlocks = [];
  List<Map<String, dynamic>> appSecondaryBlocks = [];

  getAppCourses(BuildContext? context) async {
    try {
      final response = await AppDataService.getAppCourses();

      final List<dynamic> jsonList = jsonDecode(response);

      appCourses = jsonList.map((item) => CourseModel.fromJson(item)).toList();
      
    } catch (e) {
      Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter os cursos! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
    }
  }

  getCourseDuration(BuildContext context) async {
    try {
      final response = await AppDataService.getCourseDuration(userCouseId);
      final json = jsonDecode(response);
      courseDuration = json['courseDuration'];
    } catch (e) {
      Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter a duração do curso! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
    }
  }

  getMainBlocks(BuildContext? context) async {
    try {
      final response = await AppDataService.getMainBlocks();

      final List<dynamic> jsonList = jsonDecode(response);

      appMainBlocks = jsonList.map((item) => BlockModel.fromJson(item)).toList();

    } catch (e) {
      Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter os blocos! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
    }
  }

  getSecondaryBlocks(BuildContext? context) async {
    try {
      final response = await AppDataService.getSecondaryBlocks();

      if (response.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(response);

      final updatedBlocks = jsonList.map((item) {
        return {
          'id': item['idBloco'],
          'nome': item['nomeBloco'],
          'selected': false,
        };
      }).toList();

      appSecondaryBlocks = updatedBlocks;
    } catch (e) {
      Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter os blocos! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
      return [];
    }
  }

  getAllSexualities(BuildContext? context) async {
    try {
      final response = await AppDataService.getAllSexualities();

      if (response.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(response);

      final updatedBlocks = jsonList.map((item) {
        return {
          'id': item['idBloco'],
          'nome': item['nomeBloco'],
          'selected': false,
        };
      }).toList();

      appSecondaryBlocks = updatedBlocks;
    } catch (e) {
      Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter os blocos! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
      return [];
    }
  }

  setUserCourseId(int courseId) {
    userCouseId = courseId;
  }
}
