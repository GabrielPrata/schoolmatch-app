class Artist {
  final String id;
  final String name;
  final String uri;

  Artist({
    required this.id,
    required this.name,
    required this.uri,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      uri: json['uri'],
    );
  }
}
