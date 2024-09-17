import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_year.dart';
import 'package:school_match/ui/widgets/forms/dropdown_menu.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';

class UserCourse extends StatefulWidget {
  const UserCourse({super.key});

  @override
  State<UserCourse> createState() => _UserCourseState();
}

NewUserController userController = Get.put(NewUserController());

class _UserCourseState extends State<UserCourse> {
  int? selecterSemesterId;
  String? selectedSemester;

  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() {
    if (selecterSemesterId != null && selectedSemester != null) {
      userController.setUserIdSemester(selecterSemesterId!);
      userController.setUserSemester(selectedSemester!);
      
      print(
          'Semestre selecionado: ID $selecterSemesterId, Nome $selectedSemester');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserYear(),
        ),
      );
    } 
  }

  void handleCourseSelection(int id, String name) {
    setState(() {
      selecterSemesterId = id;
      selectedSemester = name;
    });
  }

  Widget build(BuildContext context) {
    String jsonData = '''
      {
        "cursos": [
          {"id": 1, "nome": "Administração"},
          {"id": 2, "nome": "Biologia"},
          {"id": 3, "nome": "Biomedicina"},
          {"id": 4, "nome": "Contabilidade"},
          {"id": 5, "nome": "Economia"},
          {"id": 6, "nome": "Educação Física"},
          {"id": 7, "nome": "Enfermagem"},
          {"id": 8, "nome": "Engenharia Civil"},
          {"id": 9, "nome": "Engenharia de Computação"},
          {"id": 10, "nome": "Engenharia de Produção"},
          {"id": 11, "nome": "Engenharia Elétrica"},
          {"id": 12, "nome": "Engenharia Mecânica"},
          {"id": 13, "nome": "Engenharia Química"},
          {"id": 14, "nome": "Estética"},
          {"id": 15, "nome": "Farmácia"},
          {"id": 16, "nome": "Fisioterapia"},
          {"id": 17, "nome": "Odontologia"},
          {"id": 18, "nome": "Pedagogia"},
          {"id": 19, "nome": "Psicologia"},
          {"id": 20, "nome": "Química"},
          {"id": 21, "nome": "Sistemas de Informação"}
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
              "Você faz?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                child: DropdownMenuData(
              data: courses,
              onCourseSelected: handleCourseSelection,
              defaultText: "Selecione seu curso...",
            )),
            SizedBox(
              height: 470,
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
