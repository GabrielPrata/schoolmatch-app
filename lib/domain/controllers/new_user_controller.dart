import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_match/domain/models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NewUserController extends GetxController {
  var isLoading = false.obs;

  int step = 0;

  //vou salvando os valores direto no objeto, acessando a controller no decorrer das páginas
  UserModel userModel = new UserModel();

  // Métodos de coleta dos dados dos formulários.
  //As validações devem ser feitas aqui.
  setUserEmail(String userEmail) {
    userModel.email = userEmail;
  }

  setUserPassword(String userPassword) {
    userModel.senha = userPassword;
  }

  setUserName(String userName) {
    userModel.nome = userName;
  }

  setUserLastName(String userLastName) {
    userModel.sobrenome = userLastName;
  }

  setUserCourseId(int courseId) {
    userModel.idCurso = courseId;
  }

  setUserCourse(String userCourse) {
    userModel.curso = userCourse;
  }

  setUserSemester(String userSemester) {
    userModel.semestre = userSemester;
  }

  setUserIdSemester(int userIdSemester) {
    userModel.idSemestre = userIdSemester;
  }

  setUserMainBlockId(int mainBlockId) {
    userModel.idBlocoPrincipal = mainBlockId;
  }

  setUserMainBlock(String mainBlock) {
    userModel.blocoPrincipal = mainBlock;
  }

  setUserSecondaryBlocksIds(List<int> idsBlocks) {
    for (int id in idsBlocks) {
      userModel.idsBlocosSecundarios.add(id);
    }
  }

  setUserSecondaryBlocks(List<String> secondaryBlocks) {
    for (String name in secondaryBlocks) {
      userModel.blocosSecundarios.add(name);
    }
  }

  setUserImages(List<XFile> images){
    //Limpo a lista para caso o usuário já tenha selecionado as imagens e volte a tela.
    
    userModel.imagens.clear();
    for (var image in images) {
      userModel.imagens.add(image);
    }
  }

  setUserBio(String userBio){
    userModel.bio = userBio;
  }
}
