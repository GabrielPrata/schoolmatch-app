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
  List<int?> preferenceIds;
  List<String?> preferenceNames;

  SexualityModel? userSexuality;



  String? bio;
  String? city;

  CourseDurationModel? courseSemester;

  List<String?> interests;

  //Sepaprar em model (userAbout)
  String? zodiacSign;
  String? loveLanguage;
  String? pets;
  String? drink;
  String? smoker;
  String? physicalActivity;
  String? typeOfOuting;
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
    List<int?>? preferenceIds,
    List<String?>? preferenceNames,
    this.userSexuality,
    this.bio,
    this.city,
    this.zodiacSign,
    this.courseSemester,
    this.loveLanguage,
    List<String?>? interests,
    this.pets,
    this.drink,
    this.smoker,
    this.physicalActivity,
    this.typeOfOuting,
    List<XFile?>? images,
    required this.hasMusic,
    this.selectedMusic,
  })  : 
        secondaryBlocks = secondaryBlocks ?? <BlockModel?>[],
        preferenceIds = preferenceIds ?? <int?>[],
        preferenceNames = preferenceNames ?? <String?>[],
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
  preferenceIds: ${preferenceIds.join(", ")},
  preferenceNames: ${preferenceNames.join(", ")},
  sexuality: ${userSexuality?.sexualityName},
  bio: $bio,
  city: $city,
  zodiacSign: $zodiacSign,
  semester: ${courseSemester?.name},
  semesterId: ${courseSemester?.id},
  loveLanguage: $loveLanguage,
  pets: $pets,
  drink: $drink,
  smoker: $smoker,
  physicalActivity: $physicalActivity,
  typeOfOuting: $typeOfOuting,
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
      'dataNascimento':  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(birthDate!),
      'usuarioCreatedAt':  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now()),
      'generoId': userGender?.genderId,
      'genero': userGender?.genderName,
      'usuarioPreferencia': preferenceIds,
      'sexualidade': userSexuality?.sexualityName,
      'bio': bio,
      'cidade': city,
      'signo': zodiacSign,
      'semestre': courseSemester?.name,
      'semesterId': courseSemester?.id,
      'linguagemAmor': loveLanguage,
      'interesses': interests,
      'pets': pets,
      'bebida': drink,
      'fuma': smoker,
      'atividadeFisica': physicalActivity,
      'tipoRole': typeOfOuting,
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
