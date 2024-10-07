import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_images.dart';
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

class _UserInterestsState extends State<UserInterests> {
  List<String> interests = [];

  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() {
    userController.setUserInterests(interests);
    print(userController.userModel.toString());
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => UserImages(),
    //   ),
    // );
    // // }
  }

  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> interesses = [
      {"id": 1, "name": "Viajar", "selected": false},
      {"id": 2, "name": "Música", "selected": false},
      {"id": 3, "name": "Fazer amizades", "selected": false},
      {"id": 4, "name": "Sair pra date", "selected": false},
      {"id": 5, "name": "Estudar", "selected": false},
      {"id": 6, "name": "Conversar", "selected": false},
      {"id": 7, "name": "Redes sociais", "selected": false},
      {"id": 8, "name": "Caminhar", "selected": false},
      {"id": 9, "name": "Filmes", "selected": false},
      {"id": 10, "name": "Academia", "selected": false},
      {"id": 11, "name": "Experimentar coisas novas", "selected": false},
      {"id": 12, "name": "Fotografia", "selected": false},
      {"id": 13, "name": "Skate", "selected": false},
      {"id": 14, "name": "Esportes", "selected": false},
      {"id": 15, "name": "Games", "selected": false},
      {"id": 16, "name": "Artes Marciais", "selected": false},
      {"id": 17, "name": "Animais", "selected": false},
      {"id": 18, "name": "Carros", "selected": false},
      {"id": 19, "name": "Motos", "selected": false},
      {"id": 20, "name": "Dar grau", "selected": false},
      {"id": 21, "name": "Séries", "selected": false},
      {"id": 22, "name": "E-sports", "selected": false},
      {"id": 23, "name": "Tatuagens", "selected": false},
      {"id": 24, "name": "Cozinhar", "selected": false},
      {"id": 25, "name": "Futebol", "selected": false},
      {"id": 26, "name": "Roles", "selected": false},
      {"id": 27, "name": "Good Vibes", "selected": false},
      {"id": 28, "name": "Astrologia", "selected": false},
      {"id": 29, "name": "Açai", "selected": false},
      {"id": 30, "name": "Cinema", "selected": false},
      {"id": 31, "name": "Filme de terror", "selected": false},
      {"id": 32, "name": "Comédia", "selected": false},
      {"id": 33, "name": "Ciclismo", "selected": false},
      {"id": 34, "name": "Anime", "selected": false},
      {"id": 35, "name": "Moda", "selected": false},
      {"id": 36, "name": "Crossfit", "selected": false},
      {"id": 37, "name": "Pesca", "selected": false},
      {"id": 38, "name": "Balada", "selected": false},
      {"id": 39, "name": "Drinks", "selected": false},
      {"id": 40, "name": "Memes", "selected": false},
      {"id": 41, "name": "Barzinhos", "selected": false},
    ];

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
                listNames: interests,
                data: interesses,
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
