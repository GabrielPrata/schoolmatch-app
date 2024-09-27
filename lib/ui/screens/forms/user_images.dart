import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_lastname.dart';
import 'package:school_match/ui/widgets/forms/images_picker.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';

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
      _imageFiles.add(XFile("assets/emptyPhoto.png"));  // Imagem padrão
    }
    
    userController.step += 1;
  }

  // Função para selecionar as imagens
  void selectImages() async {
    try {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Substitui as imagens padrão pelas novas selecionadas
        for (var i = 0; i < selectedImages.length; i++) {
          if (_imageFiles.any((image) => image.name == 'emptyPhoto.png')) {
            // Substitui a primeira imagem padrão encontrada
            final index = _imageFiles.indexWhere((image) => image.name == 'emptyPhoto.png');
            if (index != -1) {
              _imageFiles[index] = selectedImages[i];
            }
          }
        }
      }
      setState(() {});
    } catch (e) {
      print("Erro ao selecionar a imagem: $e");
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  void enviarPrimeiroNome() {
    userController.setUserName(inputController.text);
    Get.to(() => UserLastName());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
        child: ListView(
          children: <Widget>[
            ProgressBar(userController.step),
            const SizedBox(height: 40),
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
            const SizedBox(height: 5),
            SizedBox(
              child: Text(
                "Escolha pelo menos 2 fotos.\nUma dica, deixe as melhores fotos na frente ;)",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            ImagesPicker(
              newImageFunction: selectImages,  // Aqui está passando a função
              imageFiles: _imageFiles,
              allowReorderingUserImagesOnly: true,  // Modificação importante
            ),
            SizedBox(
              height: 180,
            ),
            ElevatedButton(
              onPressed: enviarPrimeiroNome,
              child: Text(
                "PRÓXIMO",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
