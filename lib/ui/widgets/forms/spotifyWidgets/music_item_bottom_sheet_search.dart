import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/models/spotifyModels/music_adapter.dart';
import 'package:school_match/util/alerts.dart';
import 'package:school_match/util/audio_player_service.dart';

class MusicItemBottomSheetSearch extends StatefulWidget {
  final MusicAdapter track;

  const MusicItemBottomSheetSearch({
    super.key,
    required this.track,
  });

  @override
  State<MusicItemBottomSheetSearch> createState() =>
      _MusicItemBottomSheetSearchState();
}

NewUserController userController = Get.put(NewUserController());

class _MusicItemBottomSheetSearchState
    extends State<MusicItemBottomSheetSearch> {
  late String url;

  @override
  void initState() {
    super.initState();
    url = widget.track.previewUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    setUserMusic() {
      try {
        userController.setUserMusic(widget.track);
        AudioPlayerService().stopMusic();
        Alerts.showSuccessSnackBar("Música definida com sucesso!", context);

        Get.back();
      } catch (e) {
        print(e);
        Alerts.smartErrorSnackBar(
            "Erro ao definir a música, tente novamente mais tarde!", context);
      }
    }


    print(widget.track.previewUrl);

    return Container(
      margin: EdgeInsets.only(
          bottom: 15), // Adicionando uma margem na parte inferior de cada item
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              AudioPlayerService().togglePlayPause(url);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    widget.track.imageUrl.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                StreamBuilder<PlayerState>(
                  stream: AudioPlayerService().playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final isPlaying = playerState?.playing ?? false;
                    final isCurrentTrack =
                        AudioPlayerService().currentUrl == url;

                    if (widget.track.previewUrl != null) {
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
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 100,
              child: InkWell(
                splashColor: Color(0xFF1ED760),
                onTap: () {
                  Alerts.showAlertConfirmDialogMusic(
                      context, widget.track, setUserMusic);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${widget.track.musicName}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 5),
                    Text("Album: ${widget.track.albumName}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    Text(
                        "Artistas: ${widget.track.convertArtistListoToString()}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade500,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
