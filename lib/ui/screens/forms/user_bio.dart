import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_lastname.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/ui/widgets/forms/text_area_with_counter.dart';

class UserBio extends StatefulWidget {
  const UserBio({super.key});

  @override
  State<UserBio> createState() => _UserBioState();
}

NewUserController userController = Get.put(NewUserController());
TextEditingController inputController = TextEditingController();

class _UserBioState extends State<UserBio> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  enviarBio() {
    userController.setUserBio(inputController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserLastName(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result) {
        userController.step -= 1;
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.only(top: 60, left: 15, right: 15),
          child: ListView(children: <Widget>[
            ProgressBar(userController.step),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              child: Theme.of(context).brightness == Brightness.dark
                  ? Image.asset("assets/LogoSchoolMatchBranca.png")
                  : Image.asset("assets/LogoSchoolMatch.png"),
              height: 60,
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                child: Text(
              "Nos conte um pouco sobre você:",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              child: TextAreaWithCounter(controller: inputController, maxChars: 500,),
            ),
            SizedBox(
              height: 75,
            ),
            Container(
              padding: EdgeInsets.only(top: 0, left: 10, right: 10),
              child: ElevatedButton(
                style: Theme.of(context).filledButtonTheme.style,
                onPressed: () => enviarBio(),
                child: Text(
                  "PRÓXIMO",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
