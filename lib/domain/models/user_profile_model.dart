import 'package:get/get.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/domain/models/appDataModels/course_model.dart';
import 'package:school_match/domain/models/appDataModels/interests_model.dart';
import 'package:school_match/domain/models/spotifyModels/music_adapter.dart';
import 'package:intl/intl.dart';
import 'package:school_match/domain/models/user_about_model.dart';

class UserProfileModel {
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
  })  : 
        secondaryBlocks = secondaryBlocks ?? <BlockModel?>[],
        userInterests = userInterests ?? <InterestsModel?>[],
        // images = images ?? <XFile?>[] {}
        images = images ?? <String?>[] {}

  @override
  String toString() {
    return '''
UserProfileModel{
  interests: ${userInterests.join(", ")},
  firstName: $firstName,
  lastName: $lastName,
  course: ${course?.courseName},
  mainBlock: ${mainBlock?.blockName},
  secondaryBlocks: CORRIGIR DEPOIS,
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
      'dataNascimento':  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(birthDate!),
      'usuarioCreatedAt':  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now()),
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

}
