import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_firstname.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/util/alerts.dart';

class UserPassword extends StatefulWidget {
  const UserPassword({super.key});

  @override
  State<UserPassword> createState() => _UserPasswordState();
}

NewUserController userController = Get.put(NewUserController());

TextEditingController passController = TextEditingController();
TextEditingController confirmPassController = TextEditingController();

bool passIsEnabled = false;
bool confirmPassIsEnabled = false;

class _UserPasswordState extends State<UserPassword> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  savePassword() {
    try{
      userController.setUserPassword(passController.text, confirmPassController.text);
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UserFirstName(),
            ),
          );
    } catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
    
    
  }

  Widget build(BuildContext context) {
    showPass() {
      setState(() {
        passIsEnabled = !passIsEnabled;
      });
    }

    showConfirmPass() {
      setState(() {
        confirmPassIsEnabled = !confirmPassIsEnabled;
      });
    }

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
              "Qual vai ser a sua senha?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            TextField(
              style: Theme.of(context).textTheme.labelMedium,
              controller: passController,
              cursorColor: Theme.of(context).colorScheme.surface,
              keyboardType: TextInputType.text,
              obscureText: !passIsEnabled,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    showPass();
                  },
                  icon: Icon(
                    passIsEnabled ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                contentPadding: EdgeInsets.all(20),
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
                labelText: "Senha",
                labelStyle: Theme.of(context).textTheme.bodySmall,
                filled: true,
                fillColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextField(
              style: Theme.of(context).textTheme.labelMedium,
              controller: confirmPassController,
              cursorColor: Theme.of(context).colorScheme.surface,
              keyboardType: TextInputType.text,
              obscureText: !confirmPassIsEnabled,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    showConfirmPass();
                  },
                  icon: Icon(
                    confirmPassIsEnabled
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                contentPadding: EdgeInsets.all(20),
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
                labelText: "Não erra",
                labelStyle: Theme.of(context).textTheme.bodySmall,
                filled: true,
                fillColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            ElevatedButton(
              style: Theme.of(context).filledButtonTheme.style,
              onPressed: () => savePassword(),
              child: Text(
                "CRIAR SENHA",
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
