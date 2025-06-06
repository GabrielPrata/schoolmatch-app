import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/domain/models/appDataModels/course_model.dart';
import 'package:school_match/domain/models/appDataModels/interests_model.dart';
import 'package:school_match/domain/models/appDataModels/sexuality_model.dart';
import 'package:school_match/domain/services/app_data_service.dart';
import 'package:school_match/util/alerts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AppDataController extends GetxController {
  var isLoading = false.obs;
  late CourseModel userCourse;
  int courseDuration = 0;

  List<CourseModel> appCourses = [];
  List<BlockModel> appMainBlocks = [];
  List<BlockModel> appSecondaryBlocks = [];
  List<SexualityModel> appSexualities = [];
  List<InterestsModel> appInterests = [];

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
      final response =
          await AppDataService.getCourseDuration(userCourse.courseId);
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

      appMainBlocks =
          jsonList.map((item) => BlockModel.fromJson(item)).toList();
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

      final List<dynamic> jsonList = jsonDecode(response);

      appSecondaryBlocks =
          jsonList.map((item) => BlockModel.fromJson(item)).toList();
    } catch (e) {
      Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter os blocos! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
    }
  }

  getAllSexualities(BuildContext? context) async {
    try {
      final response = await AppDataService.getAllSexualities();

      final List<dynamic> jsonList = jsonDecode(response);

      appSexualities =
          jsonList.map((item) => SexualityModel.fromJson(item)).toList();
    } catch (e) {
      Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter as sexualidades! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
    }
  }

   getAllInterests(BuildContext? context) async {
    try {
      final response = await AppDataService.getAllInterests();

      final List<dynamic> jsonList = jsonDecode(response);

      appInterests =
          jsonList.map((item) => InterestsModel.fromJson(item)).toList();
    } catch (e) {
      Alerts.showErrorSnackBar(
        'Algo inesperado aconteceu ao obter os interesses! Tente novamente mais tarde ou contate o suporte.',
        context!,
      );
    }
  }

  setUserCourse(CourseModel courseModel) {
    userCourse = courseModel;
  }
}
