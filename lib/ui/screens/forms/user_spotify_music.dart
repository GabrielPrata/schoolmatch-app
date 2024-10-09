import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_lastname.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';

class UserSpotifyMusic extends StatefulWidget {
  const UserSpotifyMusic({super.key});

  @override
  State<UserSpotifyMusic> createState() => _UserSpotifyMusicState();
}

NewUserController userController = Get.put(NewUserController());
TextEditingController inputController = TextEditingController();

class _UserSpotifyMusicState extends State<UserSpotifyMusic> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() {
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
              "Atenção! É necessário ter uma conta no Spotify!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: 300,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onError,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width:
                            100, // Garante que a imagem tem largura fixa de 100
                        height:
                            100, // Garante que a imagem tem altura fixa de 100
                        child: Image.network(
                          'https://placehold.co/100/png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          width:
                              10), // Adiciona um espaço entre a imagem e o texto
                      Expanded(
                        // Faz o texto ocupar o espaço restante na linha
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Alinha os textos à esquerda
                          children: [
                            Row(
                              children: [
                                Icon(Icons.volume_up,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                                SizedBox(width: 10),
                                Text(
                                  "Minha Música:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Reza do Milhão",
                                style: Theme.of(context).textTheme.bodyMedium),
                            SizedBox(height: 5),
                            Text(
                              "Matuê - Sabor Overdose no Yakisoba",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     backgroundColor: Colors.green,
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  //   ),
                  //   onPressed: () {
                  //     // Adicione a lógica para escolher a música
                  //   },
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Icon(Icons.music_note, color: Colors.white),
                  //       SizedBox(width: 10),
                  //       Text(
                  //         "ESCOLHER MÚSICA",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0), // Ajuste do espaçamento
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0), // Tamanho do botão
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .onError, // Cor quando não selecionado
                        side: BorderSide(
                          color: Color(0xFF1ED760), // Borda
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {},
                      child: SizedBox(
                        width: double.infinity, // Largura do botão
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Centraliza os elementos no Row
                          children: [
                            SizedBox(
                              height: 35,
                              child: Image.asset('assets/spotifyIcon.png'),
                            ),
                            SizedBox(
                                width:
                                    20), // Adiciona espaço entre a imagem e o texto
                            Text(
                              "Escolher Música",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: Color(0xFF1ED760),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
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
