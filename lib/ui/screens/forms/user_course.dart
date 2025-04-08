import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_year.dart';
import 'package:school_match/ui/widgets/forms/dropdown_menu.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/util/alerts.dart';

class UserCourse extends StatefulWidget {
  const UserCourse({super.key});

  @override
  State<UserCourse> createState() => _UserCourseState();
}

NewUserController userController = Get.put(NewUserController());

class _UserCourseState extends State<UserCourse> {
  int? selectedCourseId;
  String? selectedCourse;

  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() {
    if (selectedCourseId != null && selectedCourse != null) {
      userController.setUserCourseId(selectedCourseId!);
      userController.setUserCourse(selectedCourse!);

      print(
          'Semestre selecionado: ID $selectedCourseId, Nome $selectedCourse');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserYear(),
        ),
      );
    } else {
      Alerts.showErrorSnackBar("Tá esquecendo do curso!", context);
    }
  }

  void handleCourseSelection(int id, String name) {
    setState(() {
      selectedCourseId = id;
      selectedCourse = name;
    });
  }

  Widget build(BuildContext context) {
    //TODO: ISSO VEM DA API
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
              "Você faz?",
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
              defaultText: "Selecione seu curso...",
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.48,
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
