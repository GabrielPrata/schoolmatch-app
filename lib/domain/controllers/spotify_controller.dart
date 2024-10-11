import 'package:get/get.dart';
import 'package:school_match/domain/models/spotifyModels/music_adapter.dart';
import 'package:school_match/domain/models/spotifyModels/trackResponse.dart';

class SpotifyController extends GetxController {
  late TrackResponse searchResponse;

  List<MusicAdapter> convertedMusics = [];

  var errorText = false.obs;
  var isLoading = false.obs;

  convertSpotifyModelToSystemModel() {
    convertedMusics.clear();
    for (var track in searchResponse.items) {
      MusicAdapter musicAdapter = MusicAdapter(musicName: "", artistName: []);

      for (var artist in track.artists) {
        musicAdapter.artistName.add(artist.name.toString());
      }
      musicAdapter.musicName = track.name;
      musicAdapter.albumName = track.album.name;
      musicAdapter.imageUrl = track.album.images.first.url;
      musicAdapter.previewUrl = track.previewUrl;
      convertedMusics.add(musicAdapter);
    }
  }
}
