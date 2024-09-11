import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/domain/controllers/auth_controller.dart';
import 'package:school_match/ui/screens/notification_screen.dart';
import 'package:school_match/ui/style/app_themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();
// AuthController authController = Get.put(AuthController());
String? errorText;
bool passIsEnabled = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    userController.clear();
    passController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    validaLogin() {
      // authController.validateUserLogin(userController.text, passController.text, context);
      // if (authController.errorText.value){
      //   Alerts.showErrorSnackBar("Os dados de login não podem estar vazios!", context);
      // }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NotificationScreen(),
        ),
      );
    }

    showPass() {
      setState(() {
        passIsEnabled = !passIsEnabled;
      });
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        child: ListView(children: <Widget>[
          SizedBox(
            height: 100,
          ),
          SizedBox(
            width: 300,
            height: 150,
            child: Theme.of(context).brightness == Brightness.dark ? Image.asset("assets/LogoSchoolMatchBranca.png") : Image.asset("assets/LogoSchoolMatch.png"),
          ),
          SizedBox(
            child: Text(
              "O app de relacionamento exclusivo para estudantes da FHO!",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          TextField(
            controller: userController,
            style: Theme.of(context).textTheme.labelSmall,
            cursorColor: Theme.of(context).colorScheme.surface,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, // Mantém a cor vermelha quando focado
                ),
              ),
              labelText: "E-mail",
              labelStyle: Theme.of(context).textTheme.labelSmall,
              filled: true,
              // fillColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            style: Theme.of(context).textTheme.labelSmall,
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
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              contentPadding: EdgeInsets.all(20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, // Mantém a cor vermelha quando focado
                ),
              ),
              labelText: "Senha",
              labelStyle: Theme.of(context).textTheme.labelSmall,
              filled: true,
              // fillColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(
            height: 120,
          ),
          Obx(
            () => AuthController().isLoading.value
                ? Animate(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.2, 0.9],
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).colorScheme.onPrimary
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 120,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: Theme.of(context).filledButtonTheme.style,
                          onPressed: () => validaLogin(),
                          child: Text(
                            "ENTRAR",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                          onPressed: () => validaLogin(),
                          child: Text(
                            "CRIAR CONTA",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                print("Esqueceu a senha ativado!");
                // Insira aqui a função que você deseja executar
              },
              child: Text(
                "Esqueceu a senha né!?",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
