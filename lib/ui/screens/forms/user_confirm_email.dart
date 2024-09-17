import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_password.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';

class UserConfirmEmail extends StatefulWidget {
  const UserConfirmEmail({super.key});

  @override
  State<UserConfirmEmail> createState() => _UserConfirmEmailState();
}

NewUserController userController = Get.put(NewUserController());

class _UserConfirmEmailState extends State<UserConfirmEmail> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  verificaEmail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserPassword(),
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
          padding: EdgeInsets.only(top: 60, left: 30, right: 30),
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
              "A gente te enviou um link lá no seu e-mail, clica nele, e depois pode voltar aqui.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: 430,
            ),
            ElevatedButton(
              style: Theme.of(context).filledButtonTheme.style,
              onPressed: () => verificaEmail(),
              child: Text(
                "CLIQUEI NO LINK",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
