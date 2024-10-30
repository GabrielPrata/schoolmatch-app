import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/controllers/spotify_controller.dart';
import 'package:school_match/ui/screens/forms/user_finish_signup.dart';
import 'package:school_match/ui/screens/forms/user_lastname.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/ui/widgets/forms/spotifyWidgets/show_music.dart';

class UserSpotifyMusic extends StatefulWidget {
  const UserSpotifyMusic({super.key});

  @override
  State<UserSpotifyMusic> createState() => _UserSpotifyMusicState();
}

TextEditingController inputController = TextEditingController();
SpotifyController spotifyController = Get.put(SpotifyController());
NewUserController userController = Get.put(NewUserController());

final GetStorage box = GetStorage();

class _UserSpotifyMusicState extends State<UserSpotifyMusic> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() async {
    // userController.setUserName(inputController.text);

    //Redirecionamento na controller
    await userController.saveUserData(context);
  }

  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result) {
        userController.step -= 1;
      },
      child: Obx(
        () => Scaffold(
          body: userController.isLoading.value
              ? Container(
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
                      "Peraí, é rapidão...",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Animate(
                      effects: const [MoveEffect(), ScaleEffect()],
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 160.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    )
                  ]),
                )
              : Container(
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
                      "Que música não sai da sua cabeça?",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                        child: Text(
                      "Não é necessário ter uma conta no Spotify!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                    SizedBox(height: 30),
                    ShowMusic(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Obx(
                      () => userController.userModel.hasMusic.isTrue
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.10)
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3),
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
      ),
    );
  }
}
