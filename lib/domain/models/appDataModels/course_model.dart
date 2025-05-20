class CourseModel {
  final int courseId;
  final String courseName;
  final int totalPeriodsCourse;

  CourseModel({
    required this.courseId,
    required this.courseName,
    required this.totalPeriodsCourse,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      courseId: json['courseId'],
      courseName: json['courseName'],
      totalPeriodsCourse: json['totalPeriodsCourse'],
    );
  }
}