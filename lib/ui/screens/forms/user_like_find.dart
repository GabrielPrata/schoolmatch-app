import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_city.dart';
import 'package:school_match/ui/screens/forms/user_sexuality.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';

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
  
  final List<Map<String, dynamic>> genders = [
    {"id": 1, "name": "Homens", "selected": false},
    {"id": 2, "name": "Mulheres", "selected": false},
    {"id": 3, "name": "Não Binários", "selected": false},
    {"id": 4, "name": "CAIU NA VILA O PEIXE FUZILA", "selected": false},
  ];

  salvarDados() {
    List<int> preferencesIds = [];
    List<String> preferencesNames = [];

    for (var item in genders) {
      if (item["selected"] == true) {
        preferencesIds.add(item["id"]);
        preferencesNames.add(item["name"]);
      }
    }
    userController.setUserPreferences(preferencesIds, preferencesNames);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserCity(),
      ),
    );
  }

  void checkSpecialSelection() {
    if (genders.where((gender) => gender['selected']).length == 3) {
      setState(() {
        genders.sublist(0, 3).forEach((gender) =>
            gender['selected'] = false); // Desmarca os três primeiros
        genders.last['selected'] = true; // Marca a opção especial
      });
    } else {
      setState(() {
        if (genders.last['selected']) {
          // Se a opção especial está selecionada
          genders.last['selected'] = false; // Desmarca a opção especial
        }
      });
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
                    backgroundColor: gender['selected']
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
                      gender['selected'] = !gender['selected'];
                      checkSpecialSelection();
                    });
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        gender['name'],
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: gender['selected']
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
