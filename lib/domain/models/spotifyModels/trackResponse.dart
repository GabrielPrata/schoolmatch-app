import 'package:school_match/domain/models/spotifyModels/track.dart';

class TrackResponse {
  final List<Track> items;

  TrackResponse({required this.items});

  factory TrackResponse.fromJson(Map<String, dynamic> json) {
    var trackData = json['tracks']; // Acessa o objeto 'tracks' primeiro
    if (trackData != null) {
      return TrackResponse(
        items: List<Track>.from(
          (trackData['items'] as List).map((x) => Track.fromJson(x)),
        ),
      );
    } else {
      return TrackResponse(items: []); // Retorna uma lista vazia se 'tracks' ou 'items' for null
    }
  }
}
