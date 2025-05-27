import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/models/gender_model.dart';
import 'package:school_match/ui/screens/forms/user_city.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/util/alerts.dart';

class UserLikeFind extends StatefulWidget {
  const UserLikeFind({super.key});

  @override
  State<UserLikeFind> createState() => _UserLikeFindState();
}

NewUserController userController = Get.put(NewUserController());

class _UserLikeFindState extends State<UserLikeFind> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  //TODO: ISOLAR ISSO AQUI EM UM JSON SEPARADO
  final List<GenderModel> genders = GenderModel.createAppGendersPreferences();

  salvarDados() {
    List<GenderModel> userPreferences = [];

    for (GenderModel item in genders) {
      if (item.selected == true) {
        userPreferences.add(item);
      }
    }
    try {
      userController.setUserPreferences(userPreferences);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserCity(),
        ),
      );
    } catch (e) {
      print(e);
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  void checkSpecialSelection() {
    // Conta quantas das primeiras três opções estão selecionadas
    int count = genders.take(3).where((gender) => gender.selected).length;

    // Se as três primeiras opções estão selecionadas
    if (count == 3) {
      // Desmarca as três primeiras
      for (var i = 0; i < 3; i++) {
        genders[i].selected = false;
      }
      // Marca a quarta opção
      genders.last.selected = true;
    } else {
      // Se alguma opção é selecionada enquanto a quarta está ativa
      if (genders.last.selected && count > 0) {
        genders.last.selected = false; // Desmarca a quarta opção
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.06,
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
        ),
        child: ListView(children: <Widget>[
          ProgressBar(userController.step),
          SizedBox(height: 60),
          SizedBox(
            child: Theme.of(context).brightness == Brightness.dark
                ? Image.asset("assets/LogoSchoolMatchBranca.png")
                : Image.asset("assets/LogoSchoolMatch.png"),
            height: 60,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            "Você pega...?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ...genders.map((gender) {
            return Column(
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    backgroundColor: gender.selected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).primaryColor,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      gender.selected = !gender.selected;
                      checkSpecialSelection();
                    });
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        gender.genderName,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: gender.selected
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).colorScheme.onPrimary,
                                ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            );
          }).toList(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
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
          ),
        ]),
      ),
    );
  }
}
