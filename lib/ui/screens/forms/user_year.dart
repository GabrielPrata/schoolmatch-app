import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_blocks.dart';
import 'package:school_match/ui/widgets/forms/dropdown_menu.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/util/alerts.dart';

class UserYear extends StatefulWidget {
  const UserYear({super.key});

  @override
  State<UserYear> createState() => _UserYearState();
}

NewUserController userController = Get.put(NewUserController());

class _UserYearState extends State<UserYear> {
  int? selectedSemesterId;
  String? selectedSemester;

  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() {
    if (selectedSemesterId != null && selectedSemester != null) {
      userController.setUserIdSemester(selectedSemesterId!);
      userController.setUserSemester(selectedSemester!);

      print(
          'Curso selecionado: ID $selectedSemesterId, Nome $selectedSemester');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserBlocks(),
        ),
      );
    } else {
      Alerts.showErrorSnackBar("Faltou o semestre!", context);
    }
  }

  void handleCourseSelection(int id, String name) {
    setState(() {
      selectedSemesterId = id;
      selectedSemester = name;
    });
  }

  Widget build(BuildContext context) {
    String jsonData = '''
      {
        "cursos": [
          {"id": 1, "nome": "1º semestre"},
          {"id": 2, "nome": "2º semestre"},
          {"id": 3, "nome": "3º semestre"},
          {"id": 4, "nome": "4º semestre"},
          {"id": 5, "nome": "5º semestre"},
          {"id": 6, "nome": "6º semestre"},
          {"id": 7, "nome": "7º semestre"},
          {"id": 8, "nome": "8º semestre"},
          {"id": 9, "nome": "9º semestre"},
          {"id": 10, "nome": "10º semestre"},
          {"id": 11, "nome": "11º semestre"},
          {"id": 12, "nome": "12º semestre"},
          {"id": 13, "nome": "DP é f***"}
        ]
      }''';

    Map<String, dynamic> data = jsonDecode(jsonData);
    List<Map<String, dynamic>> courses =
        List<Map<String, dynamic>>.from(data['cursos']);

    return PopScope(
      onPopInvoked: (result) {
        userController.step -= 1;
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
          ),
          child: ListView(children: <Widget>[
            ProgressBar(userController.step),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            SizedBox(
              child: Theme.of(context).brightness == Brightness.dark
                  ? Image.asset("assets/LogoSchoolMatchBranca.png")
                  : Image.asset("assets/LogoSchoolMatch.png"),
              height: 60,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
                child: Text(
              "Em qual semestre do curso você esta?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
                child: DropdownMenuData(
                    data: courses,
                    onCourseSelected: handleCourseSelection,
                    defaultText: "Selecione o semestre...")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.44,
            ),
            ElevatedButton(
              style: Theme.of(context).filledButtonTheme.style,
              onPressed: () => salvarDados(),
              child: Text(
                "PRÓXIMO",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            )
          ]),
        ),
      ),
    );
  }
}
