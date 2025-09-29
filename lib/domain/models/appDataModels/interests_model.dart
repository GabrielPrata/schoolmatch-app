class InterestsModel {
  final int interestId;
  final String interestName;

  InterestsModel({
    required this.interestId,
    required this.interestName,
  });

  factory InterestsModel.fromJson(Map<String, dynamic> json) {
    return InterestsModel(
      interestId: json['interestId'],
      interestName: json['interestName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'interestId': interestId,
      'interestName': interestName,
    };
  }
}
