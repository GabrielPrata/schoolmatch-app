import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/app_data_controller.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/models/appDataModels/sexuality_model.dart';
import 'package:school_match/ui/screens/forms/user_like_find.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/util/alerts.dart';

class UserSexuality extends StatefulWidget {
  const UserSexuality({super.key});

  @override
  State<UserSexuality> createState() => _UserSexualityState();
}

NewUserController userController = Get.put(NewUserController());
AppDataController appDataController = Get.put(AppDataController());

class _UserSexualityState extends State<UserSexuality> {
  @override
  void initState() {
    userController.step += 1;
    _loadSexualities();
    super.initState();
  }

  Future<void> _loadSexualities() async {
    if (appDataController.appSexualities.isEmpty) {
      await appDataController.getAllSexualities(context);
      setState(() {});
    }
  }

  salvarDados() {
    try {
      userController.setUserSexuality(selectedSexuality);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserLikeFind(),
        ),
      );
    } catch (e) {
      print(e);
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  SexualityModel selectedSexuality = SexualityModel(
      sexualityId: 0, sexualityName: "", sexualityDescription: "");


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
              "Qual sua orientação sexual?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Column(
                    children: appDataController.appSexualities.map((sexuality) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0), // Ajuste do espaçamento
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0), // Tamanho do botão
                            backgroundColor: sexuality.selected
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
                              appDataController.appSexualities.forEach(
                                  (g) => g.selected = false); // Desmarcar todos
                              sexuality.selected = true; // Marcar selecionado
                            });
                          },
                          child: SizedBox(
                            width: double.infinity, // Largura do botão
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sexuality.sexualityName,
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: sexuality.selected
                                              ? Theme.of(context)
                                                  .primaryColor // Cor do texto quando selecionado
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                        ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  Text(
                                    textAlign: TextAlign.left,
                                    sexuality.sexualityDescription,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: sexuality.selected
                                              ? Theme.of(context)
                                                  .primaryColor // Cor do texto quando selecionado
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.25,
                          child: Checkbox(
                            value: selectedSexuality.showInProfile,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedSexuality.showInProfile = value!;
                              });
                            },
                            checkColor: Colors.white, // cor do tick
                            fillColor:
                                WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return Theme.of(context)
                                    .colorScheme
                                    .secondary; // cor quando selecionado
                              }
                              return null; // cor padrão
                            }),
                          ),
                        ),
                        Text(
                          "Exibir no meu perfil",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
