import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_match/domain/models/user_model.dart';
import 'package:school_match/util/custom_exception.dart';
import 'package:school_match/util/validations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NewUserController extends GetxController {
  var isLoading = false.obs;

  int step = 0;

  // Salvando os valores diretamente no objeto, acessando a controller ao longo das páginas
  UserModel userModel = new UserModel();

  // Métodos para coleta de dados dos formulários.
  // As validações devem ser feitas aqui.
  setUserEmail(String userEmail) {
    var errors = Validations.verifyEmail(userEmail);
    if (errors == null)
      userModel.email = userEmail;
    else
      throw new CustomException(errors);
  }

  setUserPassword(String userPassword, String confirmPassword) {
    var errors = Validations.verifyPassword(userPassword, confirmPassword);
    if (errors == null)
      userModel.password = userPassword;
    else
      throw new CustomException(errors);
  }

  setUserName(String userName) {
    userName = Validations.capitalizeFirstLetter(userName);
    var errors = Validations.validateString(userName,
        maxLength: 60, fieldName: "Seu nome");
    if (errors == null)
      userModel.firstName = userName;
    else
      throw new CustomException(errors);
  }

  setUserLastName(String userLastName) {
    userLastName = Validations.capitalizeFirstLetter(userLastName);
    var errors = Validations.validateString(userLastName,
        maxLength: 60, fieldName: "Seu sobrenome");
    if (errors == null)
      userModel.lastName = userLastName;
    else
      throw new CustomException(errors);
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

  setUserMainBlock(int mainBlockId, String mainBlock) {
    userModel.mainBlockId = mainBlockId;
    userModel.mainBlock = mainBlock;
  }

  setUserSecondaryBlocks(List<int> idsBlocks, List<String> secondaryBlocks) {
    var errors = Validations.validateList(idsBlocks,
        maxLength: 5, minLength: 2, fieldName: "seus Blocos Secundários!");
    if (errors == null) {
      userModel.secondaryBlockIds.clear();
      userModel.secondaryBlockIds = idsBlocks;

      userModel.secondaryBlocks.clear();
      userModel.secondaryBlocks = secondaryBlocks;
    } else
      throw new CustomException(errors);
  }

  setUserImages(List<XFile> images) {
    //Uso uma imagem padrão para quando o usuário não enviou nenhuma imagem, ou seja o quadrado branco com um + na verdade é uma imagem
    //Isso faz com que o array sempre esteja cheio, portanto é nencessário remover as imagens padrão da lista para saber quantas imagens
    //o usuário de fato enviou
    //PAREI AQUI
    for (var image in images) {
      if(image.name == 'emptyPhoto.png')
        images.remove(image);
    }

    print("1.1");
    print(images.length);
    var errors = Validations.validateImages(images);
    print("1.2");
    if (errors == null) {
      print("1.3");
      userModel.images.clear();
      userModel.images = images;
    } else
      throw new CustomException(errors);
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
