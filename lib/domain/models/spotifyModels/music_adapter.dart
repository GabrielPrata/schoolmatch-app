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
}
