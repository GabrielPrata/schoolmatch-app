class SexualityModel {
  final int sexualityId;
  final String sexualityName;
  final String sexualityDescription;
  bool selected;
  bool showInProfile;

  SexualityModel({
    required this.sexualityId,
    required this.sexualityName,
    required this.sexualityDescription,
    this.selected = false,
    this.showInProfile = false,
  });

  factory SexualityModel.fromJson(Map<String, dynamic> json) {
    return SexualityModel(
      sexualityId: json['id'],
      sexualityName: json['nome'],
      sexualityDescription: json['descricao'],
    );
  }
}