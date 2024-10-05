import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_match/domain/models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NewUserController extends GetxController {
  var isLoading = false.obs;

  int step = 0;

  // Salvando os valores diretamente no objeto, acessando a controller ao longo das páginas
  UserModel userModel = new UserModel();

  // Métodos para coleta de dados dos formulários.
  // As validações devem ser feitas aqui.
  setUserEmail(String userEmail) {
    userModel.email = userEmail;
  }

  setUserPassword(String userPassword) {
    userModel.password = userPassword;
  }

  setUserName(String userName) {
    userModel.firstName = userName;
  }

  setUserLastName(String userLastName) {
    userModel.lastName = userLastName;
  }

  setUserCourseId(int courseId) {
    userModel.courseId = courseId;
  }

  setUserCourse(String userCourse) {
    userModel.course = userCourse;
  }

  setUserSemester(String userSemester) {
    userModel.semester = userSemester;
  }

  setUserIdSemester(int userIdSemester) {
    userModel.semesterId = userIdSemester;
  }

  setUserMainBlockId(int mainBlockId) {
    userModel.mainBlockId = mainBlockId;
  }

  setUserMainBlock(String mainBlock) {
    userModel.mainBlock = mainBlock;
  }

  setUserSecondaryBlocksIds(List<int> idsBlocks) {
    userModel.secondaryBlockIds.clear();
    userModel.secondaryBlockIds = idsBlocks;
  }

  setUserSecondaryBlocks(List<String> secondaryBlocks) {
    userModel.secondaryBlocks.clear();
    userModel.secondaryBlocks = secondaryBlocks;
  }

  setUserImages(List<XFile> images) {
    userModel.images.clear();
    userModel.images = images;
  }

  setUserBio(String userBio) {
    userModel.bio = userBio;
  }

  setUserBirthdate(DateTime birthdate) {
    userModel.birthDate = birthdate;
  }

  setUserGender(int genderId, String genderName) {
    userModel.genderId = genderId;
    userModel.gender = genderName;
  }

  setUserSexuality(String sexualityName, bool showSexualityInProfile) {
    userModel.sexuality = sexualityName;
    userModel.showSexuality = showSexualityInProfile;
  }

  setUserPreferences(List<int> preferencesIds, List<String> preferencesNames) {
    userModel.preferenceIds.clear();
    userModel.preferenceNames.clear();
    userModel.preferenceIds = preferencesIds;
    userModel.preferenceNames = preferencesNames;
  }

  setUserCity(String userCity) {
    userModel.city = userCity;
  }

  setUserDrink(String userDrink) {
    userModel.drink = userDrink;
  }

  setUserSmoke(String userSmoke) {
    userModel.smoker = userSmoke;
  }

  setUserSign(String userSign) {
    userModel.zodiacSign = userSign;
  }

  setUserParty(String userParty) {
    userModel.typeOfOuting = userParty;
  }

  setUserPets(String userPets) {
    userModel.pets = userPets;
  }

  setUserLoveLanguage(String userLoveLanguage) {
    userModel.loveLanguage = userLoveLanguage;
  }

  setUserPhysical(String userPhysical) {
    userModel.physicalActivity = userPhysical;
  }

  setUserInterests(List<String> interests) {
    userModel.interests.clear();
    userModel.interests = interests;
  }

}
