import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/controllers/spotify_controller.dart';
import 'package:school_match/domain/models/spotifyModels/track.dart';
import 'package:school_match/domain/models/spotifyModels/trackResponse.dart';
import 'package:school_match/domain/services/spotify_service.dart';
import 'package:school_match/ui/widgets/forms/spotifyWidgets/music_item_bottom_sheet_search.dart';
import 'package:school_match/util/alerts.dart';
import 'package:school_match/util/audio_player_service.dart';

class SearchMusicBottomSheet extends StatefulWidget {
  const SearchMusicBottomSheet({Key? key}) : super(key: key);

  @override
  State<SearchMusicBottomSheet> createState() => _SearchMusicBottomSheetState();
}

TextEditingController searchController = TextEditingController();
SpotifyController spotifyController = Get.put(SpotifyController());

class _SearchMusicBottomSheetState extends State<SearchMusicBottomSheet> {
  final GetStorage box = GetStorage();

  findMusic(String? token, String search) async {
    spotifyController.isLoading.trigger(true);
    if (token == null || token.isEmpty) {
      await SpotifyService.getAuthToken();
    }

    //Retirar essa lógica depois
    bool clearToken = false;

    if (clearToken) {
      box.remove("spotifyToken");
    }

    try {
      var musics = await SpotifyService.findMusicByName(
        userSearch: search,
        jwtToken: token!,
      );

      if (musics.statusCode != 200) {
        print("obtendo um novo token");
        if (musics.statusCode == 401) {
          //Esta caindo no catch na redundância, apresentando um erro "incorreto" para o usuário
          await SpotifyService.getAuthToken();
          await findMusic(box.read("spotifyToken").toString(), search);
        }
        // return Alerts.showErrorSnackBar("Erro ao conectar-se com o serviço do Spotify. Tente novamente mais tarde!", context);
      }

      var jsonMusics = jsonDecode(musics.body);
      spotifyController.searchResponse = TrackResponse.fromJson(jsonMusics);
      spotifyController.convertSpotifyModelToSystemModel();
    } catch (e) {
      print("Erro ao buscar a música: " + e.toString());
      return Alerts.showErrorSnackBar(
          "Erro ao conectar-se com o serviço do Spotify. Tente novamente mais tarde!",
          context);
    } finally {
      spotifyController.isLoading.trigger(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height * 0.32;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: searchController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,
                      color: Colors.black), // Cor do ícone
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear,
                        color: Colors.black), // Cor do ícone clear
                    onPressed: () {
                      searchController.clear(); // Limpa o texto do TextField
                    },
                  ),
                  labelText: 'Sua música...',
                  labelStyle:
                      TextStyle(color: Colors.black), // Cor da label
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  focusedBorder: OutlineInputBorder(
                    // Borda quando o TextField está focado
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Borda quando o TextField não está focado
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll<Color>(Color(0xFF1ED760)),
                ),
                onPressed: () => {
                  findMusic(box.read("spotifyToken"), searchController.text),
                  AudioPlayerService().stopMusic(),
                  FocusScope.of(context).unfocus(),
                },
                child: Text(
                  "Buscar...",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              Divider(),
              SizedBox(height: 15),
              Obx(
                () => spotifyController.isLoading.isTrue
                    ? CircularProgressIndicator()
                    : Container(
                        height: maxHeight,
                        child: ListView.builder(
                          primary: false,
                          itemCount: spotifyController.convertedMusics.length,
                          itemBuilder: (context, index) {
                            return MusicItemBottomSheetSearch(
                                track:
                                    spotifyController.convertedMusics[index]);
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
