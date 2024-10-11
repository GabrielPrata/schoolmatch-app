import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_match/domain/models/spotifyModels/music_adapter.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  int? courseId;
  String? course;

  int? mainBlockId;
  String? mainBlock;

  List<int?> secondaryBlockIds;
  List<String?> secondaryBlocks;

  DateTime? birthDate;
  DateTime? admissionDate;

  int? genderId;
  String? gender;

  List<int?> preferenceIds;
  List<String?> preferenceNames;

  String? sexuality;

  String? bio;
  String? city;
  String? zodiacSign;
  String? semester;
  int? semesterId;
  String? loveLanguage;
  List<String?> interests;
  String? pets;
  String? drink;
  String? smoker;
  String? physicalActivity;
  String? typeOfOuting;
  String? music;

  List<XFile?> images;

  bool? showSexuality;

  RxBool hasMusic = false.obs;
  MusicAdapter? selectedMusic;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.courseId,
    this.course,
    this.mainBlockId,
    this.mainBlock,
    List<int?>? secondaryBlockIds,
    List<String?>? secondaryBlocks,
    this.birthDate,
    this.admissionDate,
    this.genderId,
    this.gender,
    List<int?>? preferenceIds,
    List<String?>? preferenceNames,
    this.sexuality,
    this.bio,
    this.city,
    this.zodiacSign,
    this.semester,
    this.semesterId,
    this.loveLanguage,
    List<String?>? interests,
    this.pets,
    this.drink,
    this.smoker,
    this.physicalActivity,
    this.typeOfOuting,
    List<XFile?>? images,
    this.showSexuality,
    required this.hasMusic,
    this.selectedMusic,
  })  : secondaryBlockIds = secondaryBlockIds ?? <int?>[],
        secondaryBlocks = secondaryBlocks ?? <String?>[],
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
  courseId: $courseId,
  course: $course,
  mainBlockId: $mainBlockId,
  mainBlock: $mainBlock,
  secondaryBlockIds: ${secondaryBlockIds.join(", ")},
  secondaryBlocks: ${secondaryBlocks.join(", ")},
  birthDate: ${birthDate?.toIso8601String()},
  admissionDate: ${admissionDate?.toIso8601String()},
  genderId: $genderId,
  gender: $gender,
  preferenceIds: ${preferenceIds.join(", ")},
  preferenceNames: ${preferenceNames.join(", ")},
  sexuality: $sexuality,
  bio: $bio,
  city: $city,
  zodiacSign: $zodiacSign,
  semester: $semester,
  semesterId: $semesterId,
  loveLanguage: $loveLanguage,
  pets: $pets,
  drink: $drink,
  smoker: $smoker,
  physicalActivity: $physicalActivity,
  typeOfOuting: $typeOfOuting,
  music: $music,
  images: ${images.map((x) => x?.path).join(", ")},
  showSexuality: $showSexuality,
  hasMusic: $hasMusic,
  selectedMusic: ${selectedMusic?.toString() ?? 'None'},
}''';
  }
}
