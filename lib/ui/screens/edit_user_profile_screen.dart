import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/controllers/spotify_controller.dart';
import 'package:school_match/domain/controllers/user_profile_controller.dart';
import 'package:school_match/domain/models/appDataModels/sexuality_model.dart';
import 'package:school_match/domain/models/user_model.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/domain/services/account_service.dart';
import 'package:school_match/ui/widgets/collapsible_section.dart';
import 'package:school_match/ui/widgets/forms/autocomplete.dart';
import 'package:school_match/ui/widgets/forms/dropdown_menu.dart';
import 'package:school_match/ui/widgets/forms/spotifyWidgets/show_music.dart';
import 'package:school_match/ui/widgets/forms/text_area_with_counter.dart';
import 'package:school_match/ui/widgets/forms/userMoreInfos/user_more_infos_topics.dart';
import 'package:school_match/domain/controllers/app_data_controller.dart';
import 'package:school_match/domain/models/appDataModels/interests_model.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/ui/widgets/forms/filter_chip.dart';
import 'package:school_match/ui/widgets/forms/images_picker.dart';

import 'package:school_match/util/alerts.dart';
import 'package:school_match/util/validations.dart';

final List<Map<String, dynamic>> bebidasData = [
  {"id": 1, "name": "Não bebo", "selected": false},
  {"id": 2, "name": "De final de semana", "selected": false},
  {"id": 3, "name": "Raramente", "selected": false},
  {"id": 4, "name": "Em ocasiões especiais", "selected": false},
  {"id": 5, "name": "Quase toda noite", "selected": false},
  {"id": 6, "name": "Opalão 6 cilindros", "selected": false},
];

final List<Map<String, dynamic>> fumanteData = [
  {"id": 1, "name": "Quando bebo", "selected": false},
  {"id": 2, "name": "Não fumo", "selected": false},
  {"id": 3, "name": "O que? kk", "selected": false},
  {"id": 4, "name": "Não nego um pod", "selected": false},
  {"id": 5, "name": "De final de semana", "selected": false},
  {"id": 6, "name": "Não vivo sem", "selected": false},
];

final List<Map<String, dynamic>> ativFisicaData = [
  {"id": 4, "name": "Às vezes", "selected": false},
  {"id": 1, "name": "Tô no shape", "selected": false},
  {"id": 2, "name": "Todo dia", "selected": false},
  {"id": 3, "name": "Frequentemente", "selected": false},
  {"id": 5, "name": "Só para levantar da cama", "selected": false},
];

final List<Map<String, dynamic>> tipoRoleData = [
  {"id": 1, "name": "Social com os amigos", "selected": false},
  {"id": 2, "name": "Role Universitário", "selected": false},
  {"id": 3, "name": "Cama e Netflix", "selected": false},
  {"id": 4, "name": "Sou mais caseiro", "selected": false},
  {"id": 5, "name": "Rave", "selected": false},
  {"id": 6, "name": "Shows", "selected": false},
  {"id": 7, "name": "Festinha de Rep.", "selected": false},
  {"id": 8, "name": "Topo qualquer coisa", "selected": false},
];

final List<Map<String, dynamic>> petsData = [
  {"id": 1, "name": "Cachorro", "selected": false},
  {"id": 2, "name": "Gato", "selected": false},
  {"id": 3, "name": "Réptil", "selected": false},
  {"id": 4, "name": "Anfíbio", "selected": false},
  {"id": 5, "name": "Passáros", "selected": false},
  {"id": 6, "name": "Peixe", "selected": false},
  {"id": 7, "name": "Não tenho, mas amo", "selected": false},
  {"id": 8, "name": "Outro", "selected": false},
  {"id": 9, "name": "Roedores", "selected": false},
  {"id": 10, "name": "Aracnídeos", "selected": false},
  {"id": 11, "name": "Insetos", "selected": false},
  {"id": 12, "name": "Não tenho pet", "selected": false},
  {"id": 13, "name": "Gosto de todos", "selected": false},
  {"id": 14, "name": "Quero um", "selected": false},
];

final List<Map<String, dynamic>> signosData = [
  {"id": 1, "name": "Áries", "selected": false},
  {"id": 2, "name": "Touro", "selected": false},
  {"id": 3, "name": "Gêmeos", "selected": false},
  {"id": 4, "name": "Câncer", "selected": false},
  {"id": 5, "name": "Leão", "selected": false},
  {"id": 6, "name": "Virgem", "selected": false},
  {"id": 7, "name": "Libra", "selected": false},
  {"id": 8, "name": "Escorpião", "selected": false},
  {"id": 9, "name": "Sagitário", "selected": false},
  {"id": 10, "name": "Capricórnio", "selected": false},
  {"id": 11, "name": "Aquário", "selected": false},
  {"id": 12, "name": "Peixes", "selected": false},
];

final List<Map<String, dynamic>> linguagemData = [
  {"id": 1, "name": "Palavras de Afirmação", "selected": false},
  {"id": 2, "name": "Tempo de Qualidade", "selected": false},
  {"id": 3, "name": "Presentes", "selected": false},
  {"id": 4, "name": "Atos de Serviço", "selected": false},
  {"id": 5, "name": "Toque Físico", "selected": false},
];

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({super.key});

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final UserProfileController controller = Get.find();
  final NewUserController newUserController = Get.put(NewUserController());

  final AppDataController appDataController = Get.put(AppDataController());

  BlockModel? mainBlock;

  late TextEditingController _nomeController;
  late TextEditingController _sobrenomeController;
  late TextEditingController _bioController;
  late TextEditingController _cidadeController;
  late TextEditingController _semestreController;
  late TextEditingController _zodiacoController;
  late TextEditingController _linguagemAmorController;
  late TextEditingController _petsController;
  late TextEditingController _bebidaController;
  late TextEditingController _fumanteController;
  late TextEditingController _atividadeFisicaController;
  late TextEditingController _tipoRoleController;
  late TextEditingController _cursoController;
  late TextEditingController _blocoPrincipalController;

  List<InterestsModel?> _userInterests = [];
  List<BlockModel?> _userSecondaryBlocks = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  late SexualityModel selectedSexuality;
  SpotifyController spotifyController = Get.put(SpotifyController());

  void handleBlockSelection(BlockModel userBlockModel) {
    setState(() {
      mainBlock = userBlockModel;
      _blocoPrincipalController.text = userBlockModel.blockName;
    });
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> _imageFiles = [];

  Future<void> _loadInitialData() async {
    await appDataController.getAllSexualities(context);
    await appDataController.getAllInterests(context);
    await appDataController.getAppCourses(context);
    await appDataController.getMainBlocks(context);
    await appDataController.getSecondaryBlocks(context);

    UserModel userProfile = controller.userProfile.value;

    mainBlock = controller.userProfile.value.userBlock;

    for (var base64Str in userProfile.userBase64Images) {
      Uint8List bytes = base64Decode(base64Str);

      // Criar arquivo temporário
      final tempDir = await getTemporaryDirectory();
      final file =
          File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);

      _imageFiles.add(XFile(file.path));
    }
    selectedSexuality = userProfile.userSexuality!;
    _userInterests = userProfile.userInterests;
    _userSecondaryBlocks = userProfile.secondaryBlocks;

    for (var sexuality in appDataController.appSexualities) {
      if (sexuality.sexualityId == selectedSexuality.sexualityId) {
        sexuality.selected = true;
      }
    }

    _nomeController = TextEditingController(text: userProfile.firstName);
    _sobrenomeController = TextEditingController(text: userProfile.lastName);
    _bioController = TextEditingController(text: userProfile.bio);
    _cidadeController = TextEditingController(text: userProfile.city);
    _semestreController =
        TextEditingController(text: userProfile.courseSemester?.name);
    _zodiacoController =
        TextEditingController(text: userProfile.userAbout?.zodiacSign);
    _linguagemAmorController =
        TextEditingController(text: userProfile.userAbout?.loveLanguage);
    _petsController = TextEditingController(text: userProfile.userAbout?.pets);
    _bebidaController =
        TextEditingController(text: userProfile.userAbout?.drink);
    _fumanteController =
        TextEditingController(text: userProfile.userAbout?.smoker);
    _atividadeFisicaController =
        TextEditingController(text: userProfile.userAbout?.physicalActivity);
    _tipoRoleController =
        TextEditingController(text: userProfile.userAbout?.typeOfOuting);
    _cursoController =
        TextEditingController(text: userProfile.userCourse?.courseName);
    _blocoPrincipalController =
        TextEditingController(text: userProfile.userBlock?.blockName);

    setState(() {});
  }

  final box = GetStorage();

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _bioController.dispose();
    _cidadeController.dispose();
    _semestreController.dispose();
    _zodiacoController.dispose();
    _linguagemAmorController.dispose();
    _petsController.dispose();
    _bebidaController.dispose();
    _fumanteController.dispose();
    _atividadeFisicaController.dispose();
    _tipoRoleController.dispose();
    _cursoController.dispose();
    _blocoPrincipalController.dispose();
    super.dispose();
  }

  late List<String> userBase64Images = [];

  Future<void> _saveProfile() async {
    try {
      final userProfile = controller.userProfile.value;

      print("hasMusic: ${newUserController.userModel.hasMusic.isTrue}");
      if (newUserController.userModel.selectedMusic != null) {
        print(
            "selectedMusic: ${newUserController.userModel.selectedMusic!.musicName}");
      }

      if (newUserController.userModel.hasMusic.isTrue) {
        userProfile.selectedMusic = newUserController.userModel.selectedMusic;
      }

      final course = appDataController.appCourses.firstWhereOrNull(
          (element) => element.courseName == _cursoController.text);
      final mainBlock = appDataController.appMainBlocks.firstWhereOrNull(
          (element) => element.blockName == _blocoPrincipalController.text);

      var filteredImages = List<XFile>.from(
        _imageFiles.where((image) => image.name != 'emptyPhoto.png'),
      );

      userBase64Images.clear();

      for (var image in filteredImages) {
        // Lê os bytes da imagem
        Uint8List bytes = await image.readAsBytes();

        // Converte para base64
        String base64Image = base64Encode(bytes);

        // Salva no seu model (ou onde precisar)
        userBase64Images.add(base64Image);
      }

      final updatedUser = {
        "mongoId": '${box.read('mongoId')}',
        "idUsuario": '${box.read('userId')}',
        "nome": _nomeController.text,
        "sobrenome": _sobrenomeController.text,
        "sexualidade": {
          "sexualityName": selectedSexuality.sexualityName,
          "sexualityId": selectedSexuality.sexualityId,
          "showInProfile": selectedSexuality.showInProfile
        },
        "bio": _bioController.text,
        "dataNascimento": userProfile.birthDate?.toIso8601String(),
        "cidade": _cidadeController.text,
        "semestre": {"name": _semestreController.text},
        "userAbout": {
          "zodiacSign": _zodiacoController.text,
          "loveLanguage": _linguagemAmorController.text,
          "pets": _petsController.text,
          "drink": _bebidaController.text,
          "smoker": _fumanteController.text,
          "physicalActivity": _atividadeFisicaController.text,
          "typeOfOuting": _tipoRoleController.text,
        },
        "interesses": _userInterests.map((e) => e?.toJson()).toList(),
        "spotifyMusicData": userProfile.selectedMusic?.toJson(),
        "userBase64Images": userBase64Images,
        "emailUsuario": userProfile.email,
        "senhaUsuario": "", // Password is not sent
        "usuarioVerificado": true,
        "curso": course?.toJson(),
        "genero": {"genderName": userProfile.userGender?.genderName},
        "usuarioPreferencia": [], // Not implemented yet
        "usuarioCreatedAt": userProfile.admissionDate?.toIso8601String(),
        "usuarioEditedAt": DateTime.now().toIso8601String(),
        "blocoPrincipal": mainBlock?.toJson(),
        "blocosUsuario": _userSecondaryBlocks.map((e) => e?.toJson()).toList(),
        "userToken": "", // Token is not sent
      };

      final response = await AccountService.updateUserData(updatedUser);

      if (response.statusCode == 200) {
        await controller.fetchUserData();
        Alerts.showSuccessSnackBar("Perfil atualizado com sucesso!", context);
        Navigator.pop(context);
      } else {
        Alerts.showErrorSnackBar(
            "Failed to update profile. ${response.body}", context);
      }
    } catch (e) {
      Alerts.showErrorSnackBar("An error occurred: $e", context);
    }
  }

  void selectImages() async {
    try {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Substitui as imagens padrão pelas novas selecionadas
        for (var i = 0; i < selectedImages.length; i++) {
          if (_imageFiles.any((image) => image.name == 'emptyPhoto.png')) {
            // Substitui a primeira imagem padrão encontrada
            final index = _imageFiles
                .indexWhere((image) => image.name == 'emptyPhoto.png');
            if (index != -1) {
              _imageFiles[index] = selectedImages[i];
            }
          }
        }
      }
      setState(() {});
    } catch (e) {
      Alerts.showErrorSnackBar(
          "Algo deu errado ao selecionar sua imagem. Tente novamente mais tarde!",
          context);
      print("Erro ao selecionar a imagem: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Editar Perfil',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CollapsibleSection(
              icon: Icons.person,
              title: 'Nome e Sobrenome',
              child: Column(
                children: [
                  TextField(
                    style: Theme.of(context).textTheme.labelMedium,
                    cursorColor: Theme.of(context).colorScheme.surface,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 20),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      labelText: "Nome",
                      labelStyle: Theme.of(context).textTheme.bodySmall,
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onSurface,
                    ),
                    controller: _nomeController,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    style: Theme.of(context).textTheme.labelMedium,
                    cursorColor: Theme.of(context).colorScheme.surface,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 20),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      labelText: "Sobrenome",
                      labelStyle: Theme.of(context).textTheme.bodySmall,
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onSurface,
                    ),
                    controller: _sobrenomeController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.photo_camera,
              title: 'Fotos',
              child: Column(
                children: [
                  SizedBox(
                    child: Text(
                      "Suas fotos:",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ImagesPicker(
                    newImageFunction:
                        selectImages, // Aqui está passando a função
                    imageFiles: _imageFiles,
                    allowReorderingUserImagesOnly:
                        true, // Modificação importante
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.article,
              title: 'Bio',
              child: TextAreaWithCounter(
                controller: _bioController,
                maxChars: 500,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.location_city,
              title: 'Cidade',
              child: CitiesAutocomplete(controller: _cidadeController),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.school,
              title: 'Semestre',
              child: UserMoreInfosTopics(
                title: "Semestre",
                icon: Icons.school,
                data: List.generate(
                    10,
                    (index) => {
                          "id": index + 1,
                          "name": "${index + 1}º Semestre",
                          "selected": _semestreController.text ==
                              "${index + 1}º Semestre"
                        }),
                controller: _semestreController,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.dark_mode,
              title: 'Signo',
              child: UserMoreInfosTopics(
                title: "Signo",
                icon: Icons.dark_mode,
                data: signosData
                    .map((e) => {
                          ...e,
                          'selected': e['name'] == _zodiacoController.text
                        })
                    .toList(),
                controller: _zodiacoController,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.volunteer_activism,
              title: 'Linguagem do Amor',
              child: UserMoreInfosTopics(
                title: "Linguagem do Amor",
                icon: Icons.volunteer_activism,
                data: linguagemData
                    .map((e) => {
                          ...e,
                          'selected': e['name'] == _linguagemAmorController.text
                        })
                    .toList(),
                controller: _linguagemAmorController,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.pets,
              title: 'Pets',
              child: UserMoreInfosTopics(
                title: "Pets",
                icon: Icons.pets,
                data: petsData
                    .map((e) =>
                        {...e, 'selected': e['name'] == _petsController.text})
                    .toList(),
                controller: _petsController,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.local_bar,
              title: 'Você bebe?',
              child: UserMoreInfosTopics(
                title: "Você bebe?",
                icon: Icons.local_bar,
                data: bebidasData
                    .map((e) =>
                        {...e, 'selected': e['name'] == _bebidaController.text})
                    .toList(),
                controller: _bebidaController,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.smoking_rooms,
              title: 'Você fuma?',
              child: UserMoreInfosTopics(
                title: "Você fuma?",
                icon: Icons.smoking_rooms,
                data: fumanteData
                    .map((e) => {
                          ...e,
                          'selected': e['name'] == _fumanteController.text
                        })
                    .toList(),
                controller: _fumanteController,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.fitness_center,
              title: 'Atividade Física',
              child: UserMoreInfosTopics(
                title: "Atividade Física",
                icon: Icons.fitness_center,
                data: ativFisicaData
                    .map((e) => {
                          ...e,
                          'selected':
                              e['name'] == _atividadeFisicaController.text
                        })
                    .toList(),
                controller: _atividadeFisicaController,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.celebration,
              title: 'Tipo de Rolê',
              child: UserMoreInfosTopics(
                title: "Tipo de Rolê",
                icon: Icons.celebration,
                data: tipoRoleData
                    .map((e) => {
                          ...e,
                          'selected': e['name'] == _tipoRoleController.text
                        })
                    .toList(),
                controller: _tipoRoleController,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.location_city,
              title: 'Bloco Principal',
              child: SizedBox(
                child: DropdownMenuData<BlockModel>(
                  items: appDataController.appMainBlocks,
                  defaultText: "Selecione um bloco",
                  getId: (block) => block.blockId,
                  getLabel: (block) => block.blockName,
                  selectedId: controller.userProfile.value.userBlock?.blockId,
                  onItemSelected: handleBlockSelection,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.location_city,
              title: 'Blocos Secundários',
              child: CustomFilterChip(
                dataList: appDataController.appSecondaryBlocks,
                selectedItems: _userSecondaryBlocks,
                labelExtractor: (item) => item.blockName,
                idExtractor: (item) => item.blockId,
                maxSelections: 5,
                showOptions: false,
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.favorite,
              title: 'Sexualidade',
              child: Column(
                children: [
                  Column(
                    children: appDataController.appSexualities.map((sexuality) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0), // Ajuste do espaçamento
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0), // Tamanho do botão
                            backgroundColor: sexuality.selected
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimary // Cor quando selecionado
                                : Theme.of(context)
                                    .primaryColor, // Cor quando não selecionado
                            side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary, // Borda
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              for (var s in appDataController.appSexualities) {
                                s.selected = false;
                              }
                              sexuality.selected = true;
                              selectedSexuality = sexuality;
                            });
                          },
                          child: SizedBox(
                            width: double.infinity, // Largura do botão
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sexuality.sexualityName,
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: sexuality.selected
                                              ? Theme.of(context)
                                                  .primaryColor // Cor do texto quando selecionado
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                        ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  Text(
                                    textAlign: TextAlign.left,
                                    sexuality.sexualityDescription,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: sexuality.selected
                                              ? Theme.of(context)
                                                  .primaryColor // Cor do texto quando selecionado
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.25,
                          child: Checkbox(
                            value: selectedSexuality.showInProfile,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedSexuality.showInProfile = value!;
                              });
                            },
                            checkColor: Colors.white, // cor do tick
                            fillColor:
                                WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return Theme.of(context)
                                    .colorScheme
                                    .secondary; // cor quando selecionado
                              }
                              return null; // cor padrão
                            }),
                          ),
                        ),
                        Text(
                          "Exibir no meu perfil",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CollapsibleSection(
              icon: Icons.sports_cricket,
              title: 'Interesses',
              child: CustomFilterChip(
                dataList: appDataController.appInterests,
                selectedItems: _userInterests,
                labelExtractor: (item) => item.interestName,
                idExtractor: (item) => item.interestId,
                maxSelections: 5,
                showOptions: false,
              ),
            ),
            CollapsibleSection(
              icon: Icons.music_note,
              title: 'Música',
              child: ShowMusic(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: Theme.of(context).filledButtonTheme.style,
              onPressed: _saveProfile,
              child: Text('Salvar Alterações',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ],
        ),
      ),
    );
  }
}
