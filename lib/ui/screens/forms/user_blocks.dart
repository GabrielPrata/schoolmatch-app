import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_confirm_email.dart';
import 'package:school_match/ui/widgets/dropdown_menu.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/progress_bar.dart';

class UserBlocks extends StatefulWidget {
  const UserBlocks({super.key});

  @override
  State<UserBlocks> createState() => _UserBlocksState();
}

NewUserController userController = Get.put(NewUserController());

class _UserBlocksState extends State<UserBlocks> {
  int? selectedCourseId;
  String? selectedCourseName;

  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() {
    if (selectedCourseId != null && selectedCourseName != null) {
      userController.setUserCourseId(selectedCourseId!);
      userController.setUserCourse(selectedCourseName!);

      print(
          'Curso selecionado: ID $selectedCourseId, Nome $selectedCourseName');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserConfirmEmail(),
        ),
      );
    }
  }

  void handleCourseSelection(int id, String name) {
    setState(() {
      selectedCourseId = id;
      selectedCourseName = name;
    });
  }

  Widget build(BuildContext context) {
    String blocosPrincipais = '''
      {
        "cursos": [
          {"id": 1, "nome": "Bloco A (Central)"},
          {"id": 2, "nome": "Bloco B"},
          {"id": 3, "nome": "Bloco C"},
          {"id": 4, "nome": "Bloco D"},
          {"id": 5, "nome": "Bloco E"},
          {"id": 6, "nome": "Bloco F"},
          {"id": 7, "nome": "Bloco G"},
          {"id": 8, "nome": "Bloco H"},
          {"id": 9, "nome": "Bloco I"},
          {"id": 10, "nome": "Bloco J"},
          {"id": 11, "nome": "Bloco K"}
        ]
      }''';

    Map<String, dynamic> data = jsonDecode(blocosPrincipais);
    List<Map<String, dynamic>> courses =
        List<Map<String, dynamic>>.from(data['cursos']);

    return PopScope(
      onPopInvoked: (result) {
        userController.step -= 1;
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.only(top: 60, left: 30, right: 30),
          child: ListView(children: <Widget>[
            ProgressBar(userController.step),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              child: Theme.of(context).brightness == Brightness.dark
                  ? Image.asset("assets/LogoSchoolMatchBranca.png")
                  : Image.asset("assets/LogoSchoolMatch.png"),
              height: 60,
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                child: Text(
              "Quais blocos e locais você mais frequenta?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Text(
                "Selecione um bloco principal e até 5 blocos/lugares que você frequenta bastante",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              child: Text(
                "Bloco Principal",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            SizedBox(
              child: Text("Aqui, você deve escolher o bloco onde você mais tem aulas", style: Theme.of(context).textTheme.bodySmall,),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                child: DropdownMenuData(
                    data: courses,
                    onCourseSelected: handleCourseSelection,
                    defaultText: "Selecione um bloco")),
            SizedBox(
              height: 420,
            ),
            ElevatedButton(
              style: Theme.of(context).filledButtonTheme.style,
              onPressed: () => salvarDados(),
              child: Text(
                "PRÓXIMO",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
