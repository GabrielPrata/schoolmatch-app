class SpotifyImage {
  final String url;
  final int height;
  final int width;

  SpotifyImage({
    required this.url,
    required this.height,
    required this.width,
  });

  factory SpotifyImage.fromJson(Map<String, dynamic> json) {
    return SpotifyImage(
      url: json['url'],
      height: json['height'],
      width: json['width'],
    );
  }
}
