class BlockModel {
  final int blockId;
  final String blockName;

  BlockModel({
    required this.blockId,
    required this.blockName,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) {
    return BlockModel(
      blockId: json['blockId'],
      blockName: json['blockName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockId': blockId,
      'blockName': blockName,
    };
  }
}
