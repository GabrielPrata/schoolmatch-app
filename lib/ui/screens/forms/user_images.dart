import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
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

  void selectImages() async {
    try {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
      if(selectedImages!.isNotEmpty){
        _imageFiles.addAll(selectedImages);
      }
      setState(() {
        
      });
    } catch (e) {
      print("erro ao selecionar a imagem");
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    userController.step += 1;
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
            ImagesPicker(imageFiles: _imageFiles,),
            ElevatedButton(
              // onPressed: enviarPrimeiroNome,
              onPressed: selectImages,
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
