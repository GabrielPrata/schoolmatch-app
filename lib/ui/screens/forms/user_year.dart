import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/app_data_controller.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/models/appDataModels/course_duration_model.dart';
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
AppDataController appDataController = Get.put(AppDataController());

class _UserYearState extends State<UserYear> {
  int? selectedSemesterId;
  String? selectedSemester;

  @override
  void initState() {
    userController.step += 1;
    _loadCourseDuration();
    super.initState();
  }

  Future<void> _loadCourseDuration() async {
    try {
      await appDataController.getCourseDuration(context);
      setState(() {
        appDataController.isLoading
            .trigger(false); // marca que já pode construir a UI
      });
    } catch (e) {
      print("Erro ao obter a duração do curso: $e");
      setState(() {
        appDataController.isLoading
            .trigger(false); // mesmo com erro, evita loop infinito
      });
    }
  }

  Future<void> getCourseDuration() async {
    try {
      await appDataController.getCourseDuration(context);
    } catch (e) {
      print("Erro ao obter a duração do curso: $e");
    }
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

  montarListaDuracaoCurso() {
    List<CourseDurationModel> courseDurationOptions = [];

    for (var i = 1; i <= appDataController.courseDuration; i++) {
      courseDurationOptions.add(CourseDurationModel(id: i, name: "$iº Semestre"));
    }

    //Número 12 + 1 mockado por conta que os cursos mais longos possuem 12 semestres
    //
    courseDurationOptions.add(CourseDurationModel(id: 13, name: "DP é Fod*"));

    return courseDurationOptions;
  }

  void handleCourseDurationSelection(CourseDurationModel courseDurationModel) {
    setState(() {
      selectedSemesterId = courseDurationModel.id;
      selectedSemester = courseDurationModel.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (appDataController.isLoading.value) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
              child: DropdownMenuData<CourseDurationModel>(
                items: montarListaDuracaoCurso(),
                defaultText: "Selecione o semestre...",
                getId: (year) => year.id,
                getLabel: (year) => year.name,
                selectedId: selectedSemesterId,
                onItemSelected: handleCourseDurationSelection,
              ),
            ),
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
