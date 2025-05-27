import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/app_data_controller.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/models/appDataModels/interests_model.dart';

import 'package:school_match/ui/screens/forms/user_spotify_music.dart';
import 'package:school_match/ui/widgets/forms/filter_chip.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';

class UserInterests extends StatefulWidget {
  const UserInterests({super.key});

  @override
  State<UserInterests> createState() => _UserInterestsState();
}

NewUserController userController = Get.put(NewUserController());
AppDataController appDataController = Get.put(AppDataController());

class _UserInterestsState extends State<UserInterests> {
  List<InterestsModel?> userInterests = [];

  @override
  void initState() {
    userController.step += 1;
    _loadInterests();
    super.initState();
  }

  salvarDados() {
    userController.setUserInterests(userInterests);
    print(userController.userModel.toString());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserSpotifyMusic(),
      ),
    );
    // }
  }

  Future<void> _loadInterests() async {
    if (appDataController.appInterests.isEmpty) {
      await appDataController.getAllInterests(context);
      setState(() {});
    }
  }

  //TODO: ISSO VAI VIR DA API
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
              "Quais são seus interesses?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              child: CustomFilterChip(
                dataList: appDataController.appInterests,
                selectedItems: userInterests,
                labelExtractor: (item) => item.interestName,
                idExtractor: (item) => item.interestId,
                maxSelections: 5,
                showOptions: false,
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
