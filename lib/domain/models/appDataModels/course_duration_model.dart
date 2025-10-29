class CourseDurationModel {
  final int id;
  final String name;

  CourseDurationModel({
    required this.id,
    required this.name,
  });

  factory CourseDurationModel.fromJson(Map<String, dynamic> json) {
    return CourseDurationModel(
      id: json['id'],
      name: json['name'],
    );
  }
}