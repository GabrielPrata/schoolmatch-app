import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/app_data_controller.dart';
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
AppDataController appDataController = Get.put(AppDataController());

class _UserCourseState extends State<UserCourse> {
  int? selectedCourseId;
  String? selectedCourse;

  @override
  void initState() {
    userController.step += 1;
    _loadCourses();
    super.initState();
  }

  salvarDados() {
    if (selectedCourseId != null && selectedCourse != null) {
      userController.setUserCourseId(selectedCourseId!);
      userController.setUserCourse(selectedCourse!);

      print('Semestre selecionado: ID $selectedCourseId, Nome $selectedCourse');
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

  Future<void> _loadCourses() async {
    if (appDataController.appCourses.isEmpty) {
      await getAppCourses();
    }
  }

  Future<List<Map<String, dynamic>>> getAppCourses() async {
    try {
      return await appDataController.getAppCourses(context);
    } catch (e) {
      print("Erro ao decodificar JSON: $e");
      return [];
    }
  }

  void handleCourseSelection(int id, String name) {
    setState(() {
      appDataController.setUserCourseId(id);
      selectedCourseId = id;
      selectedCourse = name;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: appDataController.appCourses.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: <Widget>[
                    ProgressBar(userController.step),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    SizedBox(
                      height: 60,
                      child: Theme.of(context).brightness == Brightness.dark
                          ? Image.asset("assets/LogoSchoolMatchBranca.png")
                          : Image.asset("assets/LogoSchoolMatch.png"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      "Você faz?",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    DropdownMenuData(
                      data: appDataController.appCourses,
                      onCourseSelected: handleCourseSelection,
                      defaultText: "Selecione seu curso...",
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.48),
                    ElevatedButton(
                      style: Theme.of(context).filledButtonTheme.style,
                      onPressed: () => salvarDados(),
                      child: Text(
                        "PRÓXIMO",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ],
                ),
        ),
      ),
    );
  }
}
