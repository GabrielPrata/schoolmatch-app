class BlockModel {
  final int blockId;
  final String blockName;

  BlockModel({
    required this.blockId,
    required this.blockName,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) {
    return BlockModel(
      blockId: json['idBloco'],
      blockName: json['nomeBloco'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockId': blockId,
      'blockName': blockName,
    };
  }
}
