import 'package:school_match/domain/models/spotifyModels/album.dart';
import 'package:school_match/domain/models/spotifyModels/artist.dart';

class Track {
  final Album album;
  final List<Artist> artists;
  final Map<String, dynamic> externalIds;
  final String href;
  final String id;
  final bool isPlayable;
  final String name;
  final String? previewUrl;
  final String uri;

  Track({
    required this.album,
    required this.artists,
    required this.externalIds,
    required this.href,
    required this.id,
    required this.name,
    this.previewUrl,
    required this.uri,
    required this.isPlayable,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      album: Album.fromJson(json['album']),
      artists:
          List<Artist>.from(json['artists'].map((x) => Artist.fromJson(x))),
      externalIds: json['external_ids'],
      href: json['href'],
      id: json['id'],
      isPlayable: json['is_playable'],
      name: json['name'],
      previewUrl: json['preview_url'],
      uri: json['uri'],
    );
  }
}
