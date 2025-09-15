class UserLikeModel {
  final int senderId;
  final int recieverId;

  UserLikeModel({
    required this.senderId,
    required this.recieverId,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
    };
  }
}