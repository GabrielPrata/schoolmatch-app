import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_bio.dart';
import 'package:school_match/ui/screens/forms/user_blocks.dart';
import 'package:school_match/ui/widgets/forms/images_picker.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/util/alerts.dart';

class UserImages extends StatefulWidget {
  const UserImages({super.key});

  @override
  State<UserImages> createState() => _UserImagesState();
}

class _UserImagesState extends State<UserImages> {
  final NewUserController userController = Get.put(NewUserController());
  final TextEditingController inputController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> _imageFiles = [];

  @override
  void initState() {
    super.initState();

    // Adiciona 6 imagens padrão
    for (int i = 0; i < 6; i++) {
      _imageFiles.add(XFile("assets/emptyPhoto.png")); // Imagem padrão
    }

    userController.step += 1;
  }

  // Função para selecionar as imagens
  void selectImages() async {
    //Essa linha e esse componente é o responsável por abrir o bottomSheet para abrir se o usuário quer usar a câmera ou a galeria
    //só velho usa a câmera (que não é nosso público alvo, diga-se de passagem). Mas caso alguém questione, meio caminho já está andado para a implementação
    // BottomSheetImageUploadBy.show(context);

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
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void salvarDados() {
    try {
      userController.setUserImages(_imageFiles);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserBio(),
        ),
      );
    } catch (e) {
      print(e);
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result) {
        userController.step -= 1;
        // Get.to(UserBlocks());
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
          ),
          child: ListView(
            children: <Widget>[
              ProgressBar(userController.step),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              SizedBox(
                height: 60,
                child: Theme.of(context).brightness == Brightness.dark
                    ? Image.asset("assets/LogoSchoolMatchBranca.png")
                    : Image.asset("assets/LogoSchoolMatch.png"),
              ),
              const SizedBox(height: 30),
              SizedBox(
                child: Text(
                  "É hora das fotos!",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              SizedBox(
                child: Text(
                  "Escolha pelo menos 2 fotos.\nUma dica, deixe as melhores fotos na frente ;)",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ImagesPicker(
                newImageFunction: selectImages, // Aqui está passando a função
                imageFiles: _imageFiles,
                allowReorderingUserImagesOnly: true, // Modificação importante
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              ElevatedButton(
                onPressed: salvarDados,
                child: Text(
                  "PRÓXIMO",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
