import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_gender.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/ui/widgets/forms/user_birthdate_datepicker.dart';
import 'package:school_match/util/alerts.dart';

class UserBirthdate extends StatefulWidget {
  const UserBirthdate({super.key});

  @override
  State<UserBirthdate> createState() => _UserBirthdateState();
}

NewUserController userController = Get.put(NewUserController());
TextEditingController inputController = TextEditingController();

class _UserBirthdateState extends State<UserBirthdate> {
  @override
  void initState() {
    userController.step += 1;

    super.initState();
  }

  DateTime? selectedDate;
  void onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  salvarDados() {
    try {
      userController.setUserBirthdate(selectedDate!);
      print(selectedDate);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserGender(),
        ),
      );
    } catch (e) {
      print(e);
      if(e.toString() == "Null check operator used on a null value"){
        Alerts.showErrorSnackBar("Pensa que vai aonde? Faltou sua data de aniversário!", context);
        return;
      }  
      Alerts.showErrorSnackBar(e.toString(), context);
    }
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
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
                child: Text(
              "Você nasceu em...?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              child: UserBirthdateDatePicker(
                onDateSelected: onDateChanged,
                initialDate: null,
                firstDate: DateTime.now().subtract(Duration(days: 80 * 365)),
                lastDate: DateTime.now(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.48,
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
            )
          ]),
        ),
      ),
    );
  }
}
