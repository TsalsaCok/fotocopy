class FotocopyModel {
  final String name;
  final String type;

  FotocopyModel({required this.name, required this.type});

  factory FotocopyModel.fromJson(Map<String, dynamic> json) {
    return FotocopyModel(
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }
}
