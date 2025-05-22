import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/models/gender_model.dart';
import 'package:school_match/ui/screens/forms/user_sexuality.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/util/alerts.dart';

class UserGender extends StatefulWidget {
  const UserGender({super.key});

  @override
  State<UserGender> createState() => _UserGenderState();
}

NewUserController userController = Get.put(NewUserController());

class _UserGenderState extends State<UserGender> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() {
    try {
      userController.setUserGender(userGender!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserSexuality(),
        ),
      );
    } catch (e) {
      print(e);
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  GenderModel? userGender;

  //TODO: ISOLAR ISSO AQUI EM UM JSON SEPARADO
  final List<GenderModel> genders = GenderModel.createAppGenders();

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
              "Você se idêntifica como?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
                child: Text(
              "Não iremos exibir essa informação no seu perfil.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Column(
                    children: genders.map((gender) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0), // Ajuste do espaçamento
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0), // Tamanho do botão
                            backgroundColor: gender.selected
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimary // Cor quando selecionado
                                : Theme.of(context)
                                    .primaryColor, // Cor quando não selecionado
                            side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary, // Borda
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              genders.forEach((g) =>
                                  g.selected = false); // Desmarcar todos
                              gender.selected = true; // Marcar selecionado
                              userGender = gender;
                            });
                          },
                          child: SizedBox(
                            width: double.infinity, // Largura do botão
                            child: Center(
                              child: Text(
                                gender.genderName,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: gender.selected
                                          ? Theme.of(context)
                                              .primaryColor // Cor do texto quando selecionado
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.225),
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
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
