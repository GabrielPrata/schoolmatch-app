import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/show_user_details_bottomsheet.dart';
import 'package:school_match/util/audio_player_service.dart';
import 'package:school_match/util/functions.dart';

class UserMusic extends StatefulWidget {
  final UserProfileModel candidate;

  const UserMusic({Key? key, required this.candidate}) : super(key: key);

  @override
  _UserMusicState createState() => _UserMusicState();
}

class _UserMusicState extends State<UserMusic> {
  final AudioPlayerService _audioService = AudioPlayerService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .onError, // Use decoration to set color and borderRadius
        borderRadius: BorderRadius.circular(
            10), // Define the radius of the border corners
      ),
      child: Obx(
        () => widget.candidate.hasMusic.value
            ? Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_audioService != null) {
                        String url = widget.candidate.selectedMusic!.previewUrl
                            .toString();
                        _audioService.togglePlayPause(widget
                            .candidate.selectedMusic!.previewUrl
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
                            widget.candidate.selectedMusic!.imageUrl.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        StreamBuilder<PlayerState>(
                          stream: _audioService.playerStateStream,
                          builder: (context, snapshot) {
                            final playerState = snapshot.data;
                            final isPlaying = playerState?.playing ?? false;
                            final isCurrentTrack = _audioService.currentUrl ==
                                widget.candidate.selectedMusic!.previewUrl
                                    .toString();
                            if (widget.candidate.selectedMusic?.previewUrl !=
                                null) {
                              // Verifica se o URL existe antes de usar o ternário
                              return Icon(
                                isPlaying && isCurrentTrack
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                size: 48,
                                color: Colors.white70,
                              );
                            } else {
                              return Container(); // Retorna um widget vazio se não houver URL
                            }
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
                                color: Theme.of(context).colorScheme.onSurface),
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

                        Text(widget.candidate.selectedMusic!.musicName,
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(height: 5),
                        Text(
                          "${widget.candidate.selectedMusic?.albumName}",
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade500),
                        ),
                        Text(
                          "${widget.candidate.selectedMusic?.convertArtistListoToString()}",
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
    );
  }
}
