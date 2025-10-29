import 'package:get/get.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/domain/models/appDataModels/course_model.dart';
import 'package:school_match/domain/models/appDataModels/interests_model.dart';
import 'package:school_match/domain/models/spotifyModels/music_adapter.dart';
import 'package:intl/intl.dart';
import 'package:school_match/domain/models/user_about_model.dart';
import 'package:school_match/domain/models/user_model.dart';

class UserProfileModel {
  int userId;
  String? firstName;
  String? lastName;

  CourseModel? course;

  BlockModel? mainBlock;

  List<BlockModel?> secondaryBlocks;

  DateTime? birthDate;
  DateTime? admissionDate;

  String? sexuality;

  String? bio;
  String? city;
  String? semester;

  List<InterestsModel?> userInterests;

  UserAboutModel? userAbout;

  String? music;

  // List<XFile?> images;
  List<String?> images;

  bool? showSexuality;

  RxBool hasMusic = false.obs;
  MusicAdapter? selectedMusic;

  UserProfileModel({
    required this.userId,
    this.music,
    this.firstName,
    this.lastName,
    this.course,
    this.mainBlock,
    List<BlockModel?>? secondaryBlocks,
    this.birthDate,
    this.admissionDate,
    this.sexuality,
    this.bio,
    this.city,
    this.userAbout,
    this.semester,
    List<InterestsModel?>? userInterests,
    // List<XFile?>? images,
    List<String?>? images,
    this.showSexuality,
    required this.hasMusic,
    this.selectedMusic,
  })  : secondaryBlocks = secondaryBlocks ?? <BlockModel?>[],
        userInterests = userInterests ?? <InterestsModel?>[],
        // images = images ?? <XFile?>[] {}
        images = images ?? <String?>[] {}

  @override
  String toString() {
    return '''
UserProfileModel{
  userId: ${userId.toString()},
  interests: ${userInterests.join(", ")},
  firstName: $firstName,
  lastName: $lastName,
  course: ${course?.courseName},
  mainBlock: ${mainBlock?.blockName},
  secondaryBlocks: ${secondaryBlocks.toString()} ,
  birthDate: ${birthDate?.toIso8601String()},
  admissionDate: ${admissionDate?.toIso8601String()},
  sexuality: $sexuality,
  bio: $bio,
  city: $city,
  zodiacSign: ${userAbout?.zodiacSign},
  semester: $semester,
  loveLanguage: ${userAbout?.loveLanguage},
  pets: ${userAbout?.pets},
  drink: ${userAbout?.drink},
  smoker: ${userAbout?.smoker},
  physicalActivity: ${userAbout?.physicalActivity},
  typeOfOuting: ${userAbout?.typeOfOuting},
  music: $music,
  showSexuality: $showSexuality,
  hasMusic: implementar depois,
  selectedMusic: ${selectedMusic?.toString() ?? 'None'},
}''';
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': firstName,
      'sobrenome': lastName,
      'curso': course?.courseName,
      'blocoPrincipal': mainBlock?.blockName,
      'blocosSecundarios': secondaryBlocks,
      'dataNascimento':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(birthDate!),
      'usuarioCreatedAt':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now()),
      'sexualidade': sexuality,
      'bio': bio,
      'cidade': city,
      'signo': userAbout?.zodiacSign,
      'semestre': semester,
      'linguagemAmor': userAbout?.loveLanguage,
      'interesses': userInterests,
      'pets': userAbout?.pets,
      'bebida': userAbout?.drink,
      'fuma': userAbout?.smoker,
      'atividadeFisica': userAbout?.physicalActivity,
      'tipoRole': userAbout?.typeOfOuting,
      // 'images': images
      //     .map((x) => x?.path)
      //     .toList(), // Assumindo que você quer apenas os caminhos das imagens
      'exibirSexualidade': showSexuality,
      'hasMusic': hasMusic.value,
      'spotifyMusicData': selectedMusic?.toJson(),
      //Alterar após implementar a autenticação
      'usuarioVerificado': true,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['idUsuario'],
      firstName: json['nome'],
      lastName: json['sobrenome'],
      course:
          json['curso'] != null ? CourseModel.fromJson(json['curso']) : null,
      mainBlock: json['blocoPrincipal'] != null
          ? BlockModel.fromJson(json['blocoPrincipal'])
          : null,
      secondaryBlocks: (json['blocosUsuario'] as List<dynamic>?)
              ?.map((b) => b != null ? BlockModel.fromJson(b) : null)
              .toList() ??
          [],
      birthDate: json['dataNascimento'] != null
          ? DateTime.tryParse(json['dataNascimento'])
          : null,
      admissionDate: json['usuarioCreatedAt'] != null
          ? DateTime.tryParse(json['usuarioCreatedAt'])
          : null,
      sexuality: json['sexualidade']["sexualityName"],
      bio: json['bio'],
      city: json['cidade'],
      userAbout: json['userAbout'] != null
          ? UserAboutModel.fromJson(json['userAbout'])
          : null,
      semester: json['semestre']["name"],
      userInterests: (json['interesses'] as List<dynamic>?)
              ?.map((i) => i != null ? InterestsModel.fromJson(i) : null)
              .toList() ??
          [],
      music: json['music'],
      images: (json['userBase64Images'] as List<dynamic>?)
              ?.map((img) => img?.toString())
              .toList() ??
          [],
      showSexuality: json['sexualidade']["showInProfile"],
      hasMusic: (json['spotifyMusicData'] != null).obs,

      selectedMusic: json['spotifyMusicData'] != null
          ? MusicAdapter.fromJson(json['spotifyMusicData'])
          : null,
    );
  }

  factory UserProfileModel.fromUserModel(UserModel user, int idUsuario) {
    return UserProfileModel(
      // userId: user.idUsuario,
      firstName: user.firstName,
      lastName: user.lastName,
      course: user.userCourse,
      mainBlock: user.userBlock,
      secondaryBlocks: user.secondaryBlocks,
      birthDate: user.birthDate,
      admissionDate: user.admissionDate,
      sexuality: user.userSexuality?.sexualityName,
      bio: user.bio,
      city: user.city,
      userAbout: user.userAbout,
      semester: user.courseSemester?.name,
      userInterests: user.userInterests,
      images: user.userBase64Images,
      showSexuality: user.userSexuality?.showInProfile,
      hasMusic: user.hasMusic,
      selectedMusic: user.selectedMusic, userId: idUsuario,
    );
  }
}
