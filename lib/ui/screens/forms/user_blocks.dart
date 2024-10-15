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
import 'package:school_match/util/alerts.dart';

class UserBlocks extends StatefulWidget {
  const UserBlocks({super.key});

  @override
  State<UserBlocks> createState() => _UserBlocksState();
}

NewUserController userController = Get.put(NewUserController());

class _UserBlocksState extends State<UserBlocks> {
  int? mainBlockId;
  String? mainBlockName;

  List<int?> secondaryBlocksIds = [];
  List<String?> secondaryBlocks = [];

  final List<Map<String, dynamic>> blocosSecundarios = [
    {"id": 1, "name": "Bloco A (Central)", "selected": false},
    {"id": 2, "name": "Bloco B", "selected": false},
    {"id": 3, "name": "Bloco C", "selected": false},
    {"id": 4, "name": "Bloco D", "selected": false},
    {"id": 5, "name": "Bloco E", "selected": false},
    {"id": 6, "name": "Bloco F", "selected": false},
    {"id": 7, "name": "Bloco G", "selected": false},
    {"id": 8, "name": "Bloco H", "selected": false},
    {"id": 9, "name": "Bloco I", "selected": false},
    {"id": 10, "name": "Bloco J", "selected": false},
    {"id": 11, "name": "Bloco K", "selected": false},
    {"id": 12, "name": "Bosque", "selected": false},
    {"id": 13, "name": "Cantina", "selected": false},
    {"id": 14, "name": "ISO", "selected": false},
    {"id": 15, "name": "Violinha", "selected": false},
    {"id": 16, "name": "Boteko", "selected": false},
    {"id": 17, "name": "Espetinho", "selected": false},
    {"id": 18, "name": "Milho", "selected": false},
    {"id": 19, "name": "Banca TOP", "selected": false},
  ];

  @override
  void initState() {
    super.initState();
    userController.step += 1;
    setState(() {
      if (userController.userModel.secondaryBlockIds.isNotEmpty) {
        for (var bloco in blocosSecundarios) {
          if (secondaryBlocksIds.contains(bloco['id'])) {
            bloco['selected'] = true;
          }
        }
      }
    });
  }

  salvarDados() {
    if (mainBlockId != null && mainBlockName != null) {
      if((secondaryBlocksIds.isEmpty || secondaryBlocks.isEmpty) && userController.userModel.secondaryBlockIds.isNotEmpty){
        secondaryBlocks =  userController.userModel.secondaryBlocks;
        secondaryBlocksIds =  userController.userModel.secondaryBlockIds;
      }
      userController.setUserMainBlock(mainBlockId!, mainBlockName!);
      try {
        userController.setUserSecondaryBlocks(secondaryBlocksIds, secondaryBlocks);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserImages(),
          ),
        );
      } catch (e) {
        Alerts.showErrorSnackBar(e.toString(), context);
      }
    } else {
      Alerts.showErrorSnackBar(
          "Querem que te achem como? Escolhe seu bloco principal!", context);
    }
  }

  void handleCourseSelection(int id, String name) {
    setState(() {
      mainBlockId = id;
      mainBlockName = name;
    });
  }

  Widget build(BuildContext context) {
    String blocosPrincipais = '''
      {
        "cursos": [
          {"id": 1, "nome": "Bloco A (Central)"},
          {"id": 2, "nome": "Bloco B"},
          {"id": 3, "nome": "Bloco C"},
          {"id": 4, "nome": "Bloco D"},
          {"id": 5, "nome": "Bloco E"},
          {"id": 6, "nome": "Bloco F"},
          {"id": 7, "nome": "Bloco G"},
          {"id": 8, "nome": "Bloco H"},
          {"id": 9, "nome": "Bloco I"},
          {"id": 10, "nome": "Bloco J"},
          {"id": 11, "nome": "Bloco K"}
        ]
      }''';

    Map<String, dynamic> data = jsonDecode(blocosPrincipais);
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
              "Quais blocos e locais você mais frequenta?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              child: Text(
                "Selecione um bloco principal e até 5 blocos/lugares que você frequenta bastante",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              child: Text(
                "Bloco Principal",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            SizedBox(
              child: Text(
                "Aqui, você deve escolher o bloco onde você mais tem aulas",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              child: DropdownMenuData(
                  data: courses,
                  onCourseSelected: handleCourseSelection,
                  defaultText: "Selecione um bloco"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            SizedBox(
              child: Text(
                "Blocos Secundários",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            SizedBox(
              child: Text(
                "Escolha agora os 5 lugares que você costuma ir com frequência",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              child: CustomFilterChip(
                listIds: secondaryBlocksIds,
                listNames: secondaryBlocks,
                data: blocosSecundarios,
                maxSelections: 5,
                
              ),
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
