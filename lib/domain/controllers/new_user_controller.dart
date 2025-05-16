import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:school_match/domain/models/spotifyModels/music_adapter.dart';
import 'package:school_match/domain/models/user_model.dart';
import 'package:school_match/domain/services/auth_service.dart';
import 'package:school_match/ui/screens/forms/user_confirm_email.dart';
import 'package:school_match/ui/screens/forms/user_finish_signup.dart';
import 'package:school_match/ui/screens/forms/user_password.dart';
import 'package:school_match/util/alerts.dart';
import 'package:school_match/util/custom_exception.dart';
import 'package:school_match/util/validations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NewUserController extends GetxController {
  var isLoading = false.obs;

  int step = 0;

  // Salvando os valores diretamente no objeto, acessando a controller ao longo das páginas
  UserModel userModel = new UserModel(hasMusic: RxBool(false));
  var logger = Logger();

  checkIfEmailIsVerified(BuildContext? context) async {
    try {
      // var response = await AuthService.checkIfEmailIsVerified(userModel.email);
      // if (response.statusCode < 200 || response.statusCode >= 300) {
      //   var responseData = jsonDecode(response.body);
      //   if (response.statusCode == 403) {
      //     Alerts.showErrorSnackBar(responseData['message'], context!);
      //   } else if (response.statusCode >= 400) {
      //     Alerts.showErrorSnackBar(
      //         "Erro número ${response.statusCode}", context!);
      //   }
      //   return;
      // }
      Alerts.showSuccessSnackBar("E-mail validado com sucesso!", context!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserPassword(),
        ),
      );
    } catch (e) {
      Alerts.showErrorSnackBar(
          'Algo inesperado aconteceu! Tente novamente mais tarde ou contate o suporte.',
          context!);
    } finally {
      isLoading.trigger(false);
    }
  }

  sendEmailToVerify(BuildContext? context) async {
    try {
      var response = await AuthService.sendEmailToVerify(userModel.email);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        var responseData = jsonDecode(response.body);
        if (response.statusCode == 409) {
          Alerts.showErrorSnackBar(responseData['message'], context!);
        } else if (response.statusCode >= 400) {
          Alerts.showErrorSnackBar(
              "Erro número ${response.statusCode}", context!);
        }
        return;
      }

      Navigator.push(
        context!,
        MaterialPageRoute(
          // builder: (_) => UserConfirmEmail(),
          builder: (_) => UserPassword(),
        ),
      );
    } catch (e) {
      Alerts.showErrorSnackBar(
          'Algo inesperado aconteceu! Tente novamente mais tarde ou contate o suporte.',
          context!);
    } finally {
      isLoading.trigger(false);
    }
  }

  saveUserData(BuildContext? context) async {
    try {
      isLoading.trigger(true);

      //Futuramente remover a linha abaixo.
      var response = await AuthService.saveUserData(data: userModel);

      await Future.delayed(Duration(seconds: 5));
      print(response.body);
      // print(response.body);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        var responseData = jsonDecode(response.body);
        if (response.statusCode == 409) {
          Alerts.showErrorSnackBar(responseData['message'], context!);
        } else if (response.statusCode >= 400) {
          Alerts.showErrorSnackBar(
              "Erro número ${response.statusCode}", context!);
        }
        return;
      }
      Navigator.push(
      context!,
      MaterialPageRoute(
        builder: (_) => UserFinishSignup(),
      ),
    );
    } catch (e) {
      Alerts.showErrorSnackBar(
          'Algo inesperado aconteceu! Tente novamente mais tarde ou contate o suporte.',
          context!);
    } finally {
      isLoading.trigger(false);
    }
  }

  // Métodos para coleta de dados dos formulários.
  // As validações devem ser feitas aqui.
  setUserEmail(String userEmail) {
    var errors = Validations.verifyEmail(userEmail);
    if (errors == null)
      userModel.email = userEmail;
    else
      throw new CustomException(errors);

    print(userModel.toString());
  }

  setUserPassword(String userPassword, String confirmPassword) {
    var errors = Validations.verifyPassword(userPassword, confirmPassword);
    if (errors == null)
      userModel.password = userPassword;
    else
      throw new CustomException(errors);

    print(userModel.toString());
  }

  setUserName(String userName) {
    userName = Validations.capitalizeFirstLetter(userName);
    var errors = Validations.validateString(userName,
        maxLength: 60, fieldName: "Seu nome");
    if (errors == null)
      userModel.firstName = userName;
    else
      throw new CustomException(errors);

    print(userModel.toString());
  }

  setUserLastName(String userLastName) {
    userLastName = Validations.capitalizeFirstLetter(userLastName);
    var errors = Validations.validateString(userLastName,
        maxLength: 60, fieldName: "Seu sobrenome");
    if (errors == null)
      userModel.lastName = userLastName;
    else
      throw new CustomException(errors);

    print(userModel.toString());
  }

  setUserCourseId(int courseId) {
    userModel.courseId = courseId;
    print(userModel.toString());
  }

  setUserCourse(String userCourse) {
    userModel.course = userCourse;
    print(userModel.toString());
  }

  setUserSemester(String userSemester) {
    userModel.semester = userSemester;
    print(userModel.toString());
  }

  setUserIdSemester(int userIdSemester) {
    userModel.semesterId = userIdSemester;
    print(userModel.toString());
  }

  setUserMainBlock(int mainBlockId, String mainBlock) {
    userModel.mainBlockId = mainBlockId;
    userModel.mainBlock = mainBlock;
    print(userModel.toString());
  }

  setUserSecondaryBlocks(List<int?> idsBlocks, List<String?> secondaryBlocks) {
    var errors = Validations.validateList(idsBlocks,
        maxLength: 5, minLength: 2, fieldName: "seus Blocos Secundários!");
    if (errors == null) {
      userModel.secondaryBlockIds.clear();
      userModel.secondaryBlockIds.addAll(idsBlocks);

      userModel.secondaryBlocks.clear();
      userModel.secondaryBlocks.addAll(secondaryBlocks);
    } else
      throw new CustomException(errors);
    print(userModel.toString());
  }

  setUserImages(List<XFile> images) {
    //Uso uma imagem padrão para quando o usuário não enviou nenhuma imagem, ou seja o quadrado branco com um + na verdade é uma imagem
    //Isso faz com que o array sempre esteja cheio, portanto é nencessário remover as imagens padrão da lista para saber quantas imagens
    //o usuário de fato enviou
    var filteredImages = List<XFile>.from(
        images.where((image) => image.name != 'emptyPhoto.png'));

    var errors = Validations.validateImages(filteredImages);
    if (errors == null) {
      userModel.images.clear();
      userModel.images.addAll(images);
    } else
      throw new CustomException(errors);

    print(userModel.toString());
  }

  setUserBio(String userBio) {
    var errors = Validations.validateString(userBio,
        maxLength: 500, fieldName: "Sua bio");
    if (errors == null)
      userModel.bio = userBio;
    else
      throw new CustomException(errors);

    print(userModel.toString());
  }

  setUserBirthdate(DateTime birthdate) {
    var errors = Validations.validateDateOfBirth(birthdate);
    if (errors == null)
      userModel.birthDate = birthdate;
    else
      throw new CustomException(errors);

    print(userModel.toString());
  }

  setUserGender(int? genderId, String genderName) {
    if (genderId == null || genderId == 0) {
      throw new CustomException(
          "Por favor, nos informe como você se identifica.");
    }
    userModel.genderId = genderId;
    userModel.gender = genderName;

    print(userModel.toString());
  }

  setUserSexuality(String sexualityName, bool showSexualityInProfile) {
    if (sexualityName == null || sexualityName.isEmpty) {
      throw new CustomException(
          "Por favor, nos informe a sua orientação sexual.");
    }
    userModel.sexuality = sexualityName;
    userModel.showSexuality = showSexualityInProfile;

    print(userModel.toString());
  }

  setUserPreferences(List<int> preferencesIds, List<String> preferencesNames) {
    if (preferencesIds.isEmpty) {
      throw new CustomException(
          "Por favor, com que tipo de pessoa você se relaciona.");
    }
    userModel.preferenceIds.clear();
    userModel.preferenceNames.clear();
    userModel.preferenceIds.addAll(preferencesIds);
    userModel.preferenceNames.addAll(preferencesNames);

    print(userModel.toString());
  }

  setUserCity(String userCity) async {
    //Validação se está vazio
    if (userCity.isEmpty) {
      throw CustomException("Selecione sua cidade!");
    }
    List<String> cities = [];
    final String response =
        await rootBundle.loadString('assets/cidades_sp_mg.json');
    final data = await json.decode(response);
    List<dynamic> states = data['estados'];
    for (var state in states) {
      List<dynamic> citiesData = state['cidades'];
      cities.addAll(citiesData.cast<String>());
    }

    if (!cities.contains(userCity)) {
      // Se a cidade do usuário não estiver na lista, realiza uma ação (por exemplo, lançar uma exceção)
      throw CustomException(
          "Não encontramos '$userCity' em nosso sistema! Tente novamente ou escolha outra cidade!");
    }
    userModel.city = userCity;

    print(userModel.toString());
  }

  setUserDrink(String? userDrink) {
    userModel.drink = userDrink;
    print(userModel.toString());
  }

  setUserSmoke(String? userSmoke) {
    userModel.smoker = userSmoke;
    print(userModel.toString());
  }

  setUserSign(String? userSign) {
    userModel.zodiacSign = userSign;
    print(userModel.toString());
  }

  setUserParty(String? userParty) {
    userModel.typeOfOuting = userParty;
    print(userModel.toString());
  }

  setUserPets(String? userPets) {
    userModel.pets = userPets;
    print(userModel.toString());
  }

  setUserLoveLanguage(String? userLoveLanguage) {
    userModel.loveLanguage = userLoveLanguage;
    print(userModel.toString());
  }

  setUserPhysical(String? userPhysical) {
    userModel.physicalActivity = userPhysical;
    print(userModel.toString());
  }

  setUserInterests(List<String> interests) {
    userModel.interests.clear();
    userModel.interests.addAll(interests);
    print(userModel.toString());
  }

  setUserMusic(MusicAdapter track) {
    userModel.selectedMusic = track;
    userModel.hasMusic?.trigger(true);
    Get.back();
  }
}
