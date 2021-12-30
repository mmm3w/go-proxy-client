class NiData {
  String id;
  String name;

  NiData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
      };
}
