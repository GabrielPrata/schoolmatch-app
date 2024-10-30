import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_password.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';

class UserFinishSignup extends StatefulWidget {
  const UserFinishSignup({super.key});

  @override
  State<UserFinishSignup> createState() => _UserFinishSignupState();
}

NewUserController userController = Get.put(NewUserController());

class _UserFinishSignupState extends State<UserFinishSignup> {
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
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
          ),
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
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
                child: Text(
              "CADASTRO FINALIZADO! VOU TERMINAR ESSA TELA DEPOIS",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.43,
            ),
            ElevatedButton(
              style: Theme.of(context).filledButtonTheme.style,
              onPressed: () => verificaEmail(),
              child: Text(
                "BOTAO BONITO E LEGAL",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            )
          ]),
        ),
      ),
    );
  }
}
