import 'package:get/get.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/domain/models/appDataModels/course_model.dart';
import 'package:school_match/domain/models/spotifyModels/music_adapter.dart';
import 'package:intl/intl.dart';

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
  String? zodiacSign;
  String? semester;
  String? loveLanguage;
  List<String?> interests;
  String? pets;
  String? drink;
  String? smoker;
  String? physicalActivity;
  String? typeOfOuting;
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
    List<int?>? preferenceIds,
    this.sexuality,
    this.bio,
    this.city,
    this.zodiacSign,
    this.semester,
    this.loveLanguage,
    List<String?>? interests,
    this.pets,
    this.drink,
    this.smoker,
    this.physicalActivity,
    this.typeOfOuting,
    // List<XFile?>? images,
    List<String?>? images,
    this.showSexuality,
    required this.hasMusic,
    this.selectedMusic,
  })  : 
        secondaryBlocks = secondaryBlocks ?? <BlockModel?>[],
        interests = interests ?? <String?>[],
        // images = images ?? <XFile?>[] {}
        images = images ?? <String?>[] {}

  @override
  String toString() {
    return '''
UserProfileModel{
  interests: ${interests.join(", ")},
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
  zodiacSign: $zodiacSign,
  semester: $semester,
  loveLanguage: $loveLanguage,
  pets: $pets,
  drink: $drink,
  smoker: $smoker,
  physicalActivity: $physicalActivity,
  typeOfOuting: $typeOfOuting,
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
      'signo': zodiacSign,
      'semestre': semester,
      'linguagemAmor': loveLanguage,
      'interesses': interests,
      'pets': pets,
      'bebida': drink,
      'fuma': smoker,
      'atividadeFisica': physicalActivity,
      'tipoRole': typeOfOuting,
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
