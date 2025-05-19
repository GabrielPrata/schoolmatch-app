import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/app_data_controller.dart';
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
AppDataController appDataController = Get.put(AppDataController());

class _UserBlocksState extends State<UserBlocks> {
  int? mainBlockId;
  String? mainBlockName;

  List<int?> secondaryBlocksIds = [];
  List<String?> secondaryBlocks = [];

  @override
  void initState() {
    _loadBlocks();
    userController.step += 1;
    super.initState();
    setState(() {
      if (userController.userModel.secondaryBlockIds.isNotEmpty) {
        for (var bloco in appDataController.appSecondaryBlocks) {
          if (secondaryBlocksIds.contains(bloco['id'])) {
            bloco['selected'] = true;
          }
        }
      }
    });
  }

  Future<void> _loadBlocks() async {
    if (appDataController.appMainBlocks.isEmpty) {
      await appDataController.getMainBlocks(context);
      setState(() {});
    }
    if (appDataController.appSecondaryBlocks.isEmpty) {
      await appDataController.getSecondaryBlocks(context);
      setState(() {});
    }
  }

  salvarDados() {
    if (mainBlockId != null && mainBlockName != null) {
      if ((secondaryBlocksIds.isEmpty || secondaryBlocks.isEmpty) &&
          userController.userModel.secondaryBlockIds.isNotEmpty) {
        secondaryBlocks = userController.userModel.secondaryBlocks;
        secondaryBlocksIds = userController.userModel.secondaryBlockIds;
      }
      userController.setUserMainBlock(mainBlockId!, mainBlockName!);
      try {
        userController.setUserSecondaryBlocks(
            secondaryBlocksIds, secondaryBlocks);

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
                  data: appDataController.appMainBlocks,
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
                data: appDataController.appSecondaryBlocks,
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
