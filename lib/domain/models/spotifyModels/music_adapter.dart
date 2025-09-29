class MusicAdapter {
  String musicName = "";
  List<String> artistName = [];
  String? albumName = "";
  String? imageUrl = "";
  String? previewUrl = "";

  MusicAdapter({
    required this.musicName,
    required this.artistName,
    this.albumName,
    this.imageUrl,
    this.previewUrl,
  });

  String convertArtistListoToString() {
    String allArtists = artistName.join(", ");

    return allArtists;
  }

  Map<String, dynamic> toJson() {
    return {
      'musicName': musicName,
      'artistName': artistName,
      'albumName': albumName,
      'imageUrl': imageUrl,
      'previewUrl': previewUrl,
    };
  }

  factory MusicAdapter.fromJson(Map<String, dynamic> json) {
    return MusicAdapter(
      musicName: json['musicName'] ?? "",
      artistName: (json['artistName'] as List<dynamic>?)
              ?.map((a) => a.toString())
              .toList() ??
          [],
      albumName: json['albumName'],
      imageUrl: json['imageUrl'],
      previewUrl: json['previewUrl'],
    );
  }
}
