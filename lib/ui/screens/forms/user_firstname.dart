import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_lastname.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/progress_bar.dart';

class UserFirstName extends StatefulWidget {
  const UserFirstName({super.key});

  @override
  State<UserFirstName> createState() => _UserFirstNameState();
}

NewUserController userController = Get.put(NewUserController());
TextEditingController inputController = TextEditingController();

class _UserFirstNameState extends State<UserFirstName> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  enviarPrimeiroNome() {
    userController.setUserName(inputController.text);
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
              "Qual seu primeiro nome?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              child: TextField(
                controller: inputController,
                style: Theme.of(context).textTheme.labelMedium,
                cursorColor: Theme.of(context).colorScheme.surface,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  labelText: "Nome",
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(
              height: 420,
            ),
            ElevatedButton(
              style: Theme.of(context).filledButtonTheme.style,
              onPressed: () => enviarPrimeiroNome(),
              child: Text(
                "PRÓXIMO",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
