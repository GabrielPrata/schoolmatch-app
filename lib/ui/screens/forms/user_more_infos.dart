import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_images.dart';
import 'package:school_match/ui/widgets/forms/dropdown_menu.dart';
import 'package:school_match/ui/widgets/forms/filter_chip.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/ui/widgets/forms/unique_filter_chip.dart';
import 'package:school_match/ui/widgets/forms/userMoreInfos/user_more_infos_topics.dart';

class UserMoreInfos extends StatefulWidget {
  const UserMoreInfos({super.key});

  @override
  State<UserMoreInfos> createState() => _UserMoreInfosState();
}

NewUserController userController = Get.put(NewUserController());
TextEditingController bebidaController = TextEditingController();
TextEditingController fumanteController = TextEditingController();
TextEditingController petsController = TextEditingController();
TextEditingController ativFisicaController = TextEditingController();
TextEditingController tipoRoleController = TextEditingController();
TextEditingController signoController = TextEditingController();
TextEditingController linguagemController = TextEditingController();

class _UserMoreInfosState extends State<UserMoreInfos> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() {
    userController.setUserDrink(bebidaController.text);
    userController.setUserSmoke(fumanteController.text);
    userController.setUserPhysical(ativFisicaController.text);
    userController.setUserSign(signoController.text);
    userController.setUserParty(tipoRoleController.text);
    userController.setUserPets(petsController.text);
    userController.setUserLoveLanguage(linguagemController.text);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => UserImages(),
    //   ),
    // );
  }

  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bebidasData = [
      {"id": 1, "name": "Não bebo", "selected": false},
      {"id": 2, "name": "De final de semana", "selected": false},
      {"id": 3, "name": "Raramente", "selected": false},
      {"id": 4, "name": "Em ocasiões especiais", "selected": false},
      {"id": 5, "name": "Quase toda noite", "selected": false},
      {"id": 6, "name": "Opalão 6 cilindros", "selected": false},
    ];

    final List<Map<String, dynamic>> fumanteData = [
      {"id": 1, "name": "Quando bebo", "selected": false},
      {"id": 2, "name": "Não fumo", "selected": false},
      {"id": 3, "name": "O que? kk", "selected": false},
      {"id": 4, "name": "Não nego um pod", "selected": false},
      {"id": 5, "name": "De final de semana", "selected": false},
      {"id": 6, "name": "Não vivo sem", "selected": false},
    ];

    final List<Map<String, dynamic>> ativFisicaData = [
      {"id": 4, "name": "Às vezes", "selected": false},
      {"id": 1, "name": "Tô no shape", "selected": false},
      {"id": 2, "name": "Todo dia", "selected": false},
      {"id": 3, "name": "Frequentemente", "selected": false},
      {"id": 5, "name": "Só para levantar da cama", "selected": false},
    ];

    final List<Map<String, dynamic>> tipoRoleData = [
      {"id": 1, "name": "Social com os amigos", "selected": false},
      {"id": 2, "name": "Role Universitário", "selected": false},
      {"id": 3, "name": "Cama e Netflix", "selected": false},
      {"id": 4, "name": "Sou mais caseiro", "selected": false},
      {"id": 5, "name": "Rave", "selected": false},
      {"id": 6, "name": "Shows", "selected": false},
      {"id": 7, "name": "Festinha de Rep.", "selected": false},
      {"id": 8, "name": "Topo qualquer coisa", "selected": false},
    ];

    final List<Map<String, dynamic>> petsData = [
      {"id": 1, "name": "Cachorro", "selected": false},
      {"id": 2, "name": "Gato", "selected": false},
      {"id": 3, "name": "Réptil", "selected": false},
      {"id": 4, "name": "Anfíbio", "selected": false},
      {"id": 5, "name": "Passáros", "selected": false},
      {"id": 6, "name": "Peixe", "selected": false},
      {"id": 7, "name": "Não tenho, mas amo", "selected": false},
      {"id": 8, "name": "Outro", "selected": false},
      {"id": 9, "name": "Roedores", "selected": false},
      {"id": 10, "name": "Aracnídeos", "selected": false},
      {"id": 11, "name": "Insetos", "selected": false},
      {"id": 12, "name": "Não tenho pet", "selected": false},
      {"id": 13, "name": "Gosto de todos", "selected": false},
      {"id": 14, "name": "Quero um", "selected": false},
    ];

    final List<Map<String, dynamic>> signosData = [
      {"id": 1, "name": "Áries", "selected": false},
      {"id": 2, "name": "Touro", "selected": false},
      {"id": 3, "name": "Gêmeos", "selected": false},
      {"id": 4, "name": "Câncer", "selected": false},
      {"id": 5, "name": "Leão", "selected": false},
      {"id": 6, "name": "Virgem", "selected": false},
      {"id": 7, "name": "Libra", "selected": false},
      {"id": 8, "name": "Escorpião", "selected": false},
      {"id": 9, "name": "Sagitário", "selected": false},
      {"id": 10, "name": "Capricórnio", "selected": false},
      {"id": 11, "name": "Aquário", "selected": false},
      {"id": 12, "name": "Peixes", "selected": false},
    ];

    final List<Map<String, dynamic>> linguagemData = [
      {"id": 1, "name": "Palavras de Afirmação", "selected": false},
      {"id": 2, "name": "Tempo de Qualidade", "selected": false},
      {"id": 3, "name": "Presentes", "selected": false},
      {"id": 4, "name": "Atos de Serviço", "selected": false},
      {"id": 5, "name": "Toque Físico", "selected": false},
    ];

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
              "Sobre você:",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              child: Text(
                "Essas informações não são obrigatórias. Caso não queira responder alguma coisa, ta suave!",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            UserMoreInfosTopics(
              title: "Você bebe?",
              icon: Icons.local_bar,
              data: bebidasData,
              controller: bebidaController,
            ),
            UserMoreInfosTopics(
              title: "Você Fuma?",
              icon: Icons.smoking_rooms,
              data: fumanteData,
              controller: fumanteController,
            ),
            UserMoreInfosTopics(
              title: "Atividades Físicas?",
              icon: Icons.fitness_center,
              data: ativFisicaData,
              controller: ativFisicaController,
            ),
            UserMoreInfosTopics(
              title: "Seu signo?",
              icon: Icons.dark_mode,
              data: signosData,
              controller: bebidaController,
            ),
            UserMoreInfosTopics(
              title: "Qual seu tipo de rolê?",
              icon: Icons.celebration,
              data: tipoRoleData,
              controller: bebidaController,
            ),
            UserMoreInfosTopics(
              title: "Gosta de animais?",
              icon: Icons.pets,
              data: petsData,
              controller: bebidaController,
            ),
            UserMoreInfosTopics(
              title: "Sua linguagem do amor?",
              icon: Icons.volunteer_activism,
              data: linguagemData,
              controller: bebidaController,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
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
      ),
    );
  }
}
