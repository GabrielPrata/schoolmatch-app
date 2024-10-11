import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/controllers/spotify_controller.dart';
import 'package:school_match/ui/widgets/forms/spotifyWidgets/search_music_bottom_sheet.dart';
import 'package:school_match/util/audio_player_service.dart';

class ShowMusic extends StatefulWidget {
  const ShowMusic({
    super.key,
  });

  @override
  State<ShowMusic> createState() => _ShowMusicState();
}

SpotifyController spotifyController = Get.put(SpotifyController());
NewUserController userController = Get.put(NewUserController());

class _ShowMusicState extends State<ShowMusic> {
  final AudioPlayerService _audioService = AudioPlayerService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(20),
      width: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onError,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => userController.userModel.hasMusic.isTrue
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_audioService != null) {
                            String url = userController
                                .userModel.selectedMusic!.previewUrl
                                .toString();
                            _audioService.togglePlayPause(userController
                                .userModel.selectedMusic!.previewUrl
                                .toString());
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.network(
                                userController.userModel.selectedMusic!.imageUrl
                                    .toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            StreamBuilder<PlayerState>(
                              stream: _audioService.playerStateStream,
                              builder: (context, snapshot) {
                                final playerState = snapshot.data;
                                final isPlaying = playerState?.playing ?? false;
                                final isCurrentTrack =
                                    _audioService.currentUrl ==
                                        userController
                                            .userModel.selectedMusic!.previewUrl
                                            .toString();
                                return Icon(
                                  isPlaying && isCurrentTrack
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill,
                                  size: 48,
                                  color: Colors.white70,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ), // Adiciona um espaço entre a imagem e o texto
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
                            //Esses valores virão da UserModel após o usuário selecionar a música desejada

                            Text(
                                userController
                                    .userModel.selectedMusic!.musicName,
                                style: Theme.of(context).textTheme.bodyMedium),
                            SizedBox(height: 5),
                            Text(
                              "${userController.userModel.selectedMusic?.albumName}",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade500),
                            ),
                            Text(
                              "${userController.userModel.selectedMusic?.convertArtistListoToString()}",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
          Obx(
            () => userController.userModel.hasMusic.isTrue
                ? SizedBox(height: 30)
                : SizedBox(height: 0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 3.0), // Ajuste do espaçamento
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(vertical: 10.0), // Tamanho do botão
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
              onPressed: () {
                // await findMusic(box.read("spotifyToken").toString(), "lady gaga");
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    enableDrag: true,
                    showDragHandle: true,
                    builder: (BuildContext context) {
                      return SearchMusicBottomSheet();
                    });
              },
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
                        width: 20), // Adiciona espaço entre a imagem e o texto
                    Text(
                      "Escolher Música",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
    );
  }
}
