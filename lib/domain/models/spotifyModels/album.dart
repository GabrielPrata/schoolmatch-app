import 'package:school_match/domain/models/spotifyModels/artist.dart';
import 'package:school_match/domain/models/spotifyModels/spotify_image.dart';

class Album {
  final String albumType;
  final int totalTracks;
  final Map<String, String> externalUrls;
  final String href;
  final String id;
  final List<SpotifyImage> images;
  final String name;
  final String releaseDate;
  final String releaseDatePrecision;
  final String type;
  final String uri;
  final List<Artist> artists;
  final bool isPlayable;

  Album({
    required this.albumType,
    required this.totalTracks,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.releaseDate,
    required this.releaseDatePrecision,
    required this.type,
    required this.uri,
    required this.artists,
    required this.isPlayable,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumType: json['album_type'],
      totalTracks: json['total_tracks'],
      externalUrls: Map<String, String>.from(json['external_urls']),
      href: json['href'],
      id: json['id'],
      images: List<SpotifyImage>.from(json['images'].map((x) => SpotifyImage.fromJson(x))),
      name: json['name'],
      releaseDate: json['release_date'],
      releaseDatePrecision: json['release_date_precision'],
      type: json['type'],
      uri: json['uri'],
      artists: List<Artist>.from(json['artists'].map((x) => Artist.fromJson(x))),
      isPlayable: json['is_playable'],
    );
  }
}