import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/domain/models/appDataModels/course_duration_model.dart';
import 'package:school_match/domain/models/appDataModels/course_model.dart';
import 'package:school_match/domain/models/appDataModels/sexuality_model.dart';
import 'package:school_match/domain/models/gender_model.dart';
import 'package:school_match/domain/models/spotifyModels/music_adapter.dart';
import 'package:intl/intl.dart';
import 'package:school_match/domain/models/user_about_model.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_about.dart';

class UserModel {
  //Sepaprar em model
  //User herança
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  CourseModel? userCourse;

  BlockModel? userBlock;

  List<BlockModel?> secondaryBlocks;

  DateTime? birthDate;
  DateTime? admissionDate;

  GenderModel? userGender;

  //Sepaprar em model (usar model de genero)
  List<GenderModel?> userGenderPreferences;

  SexualityModel? userSexuality;

  String? bio;
  String? city;

  CourseDurationModel? courseSemester;

  List<String?> interests;

  UserAboutModel? userAbout;
  // String? music;

  List<XFile?> images;

  RxBool hasMusic = false.obs;
  MusicAdapter? selectedMusic;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.userCourse,
    this.userBlock,
    List<BlockModel?>? secondaryBlocks,
    this.birthDate,
    this.admissionDate,
    this.userGender,
    List<GenderModel?>? userGenderPreferences,
    this.userSexuality,
    this.bio,
    this.city,
    this.courseSemester,
    List<String?>? interests,
    this.userAbout,
    List<XFile?>? images,
    required this.hasMusic,
    this.selectedMusic,
  })  : secondaryBlocks = secondaryBlocks ?? <BlockModel?>[],
        userGenderPreferences = userGenderPreferences ?? <GenderModel?>[],
        interests = interests ?? <String?>[],
        images = images ?? <XFile?>[] {}

  @override
  String toString() {
    return '''
UserModel{
  interests: ${interests.join(", ")},
  firstName: $firstName,
  lastName: $lastName,
  email: $email,
  password: $password,
  courseId: ${userCourse?.courseId},
  course: ${userCourse?.courseName},
  mainBlockId: ${userBlock?.blockId},
  mainBlock: ${userBlock?.blockName},
  secondaryBlockIds: CORRIGIR DEPOIS,
  secondaryBlocks: CORRIGIR DEPOIS,
  birthDate: ${birthDate?.toIso8601String()},
  admissionDate: ${admissionDate?.toIso8601String()},
  genderId: ${userGender?.genderId},
  gender: ${userGender?.genderName},
  preferenceIds: ${userGenderPreferences.join(", ")},
  preferenceNames: ${userGenderPreferences.join(", ")},
  sexuality: ${userSexuality?.sexualityName},
  bio: $bio,
  city: $city,
  zodiacSign: ${userAbout?.zodiacSign},
  semester: ${courseSemester?.name},
  semesterId: ${courseSemester?.id},
  loveLanguage: ${userAbout?.loveLanguage},
  pets: ${userAbout?.pets},
  drink: ${userAbout?.drink},
  smoker: ${userAbout?.smoker},
  physicalActivity: ${userAbout?.physicalActivity},
  typeOfOuting: ${userAbout?.typeOfOuting},
  music: -,
  images: ${images.map((x) => x?.path).join(", ")},
  showSexuality: ${userSexuality?.showInProfile},
  hasMusic: $hasMusic,
  selectedMusic: ${selectedMusic?.toString() ?? 'None'},
}''';
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': firstName,
      'sobrenome': lastName,
      'emailUsuario': email,
      'senhaUsuario': md5.convert(utf8.encode(password!)).toString(),
      'cursoId': userCourse?.courseId,
      'curso': userCourse?.courseName,
      'blocoPrincipalId': userBlock?.blockId,
      'blocoPrincipal': userBlock?.blockName,
      'BlocosUsuario': userBlock,
      'blocosSecundarios': secondaryBlocks,
      'dataNascimento':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(birthDate!),
      'usuarioCreatedAt':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now()),
      'generoId': userGender?.genderId,
      'genero': userGender?.genderName,
      'usuarioPreferencia': userGenderPreferences,
      'sexualidade': userSexuality?.sexualityName,
      'bio': bio,
      'cidade': city,
      'signo': userAbout?.zodiacSign,
      'semestre': courseSemester?.name,
      'semesterId': courseSemester?.id,
      'linguagemAmor': userAbout?.loveLanguage,
      'interesses': interests,
      'pets': userAbout?.pets,
      'bebida': userAbout?.drink,
      'fuma': userAbout?.smoker,
      'atividadeFisica': userAbout?.physicalActivity,
      'tipoRole': userAbout?.typeOfOuting,
      'images': images
          .map((x) => x?.path)
          .toList(), // Assumindo que você quer apenas os caminhos das imagens
      'exibirSexualidade': userSexuality?.showInProfile,
      'hasMusic': hasMusic.value,
      'spotifyMusicData': selectedMusic?.toJson(),
      //Alterar após implementar a autenticação
      'usuarioVerificado': true,
    };
  }
}
