class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
  });

  // factory Pokemon.fromJson(Map<String, dynamic> json) {
  //   return Pokemon(
  //     id: json['id'],
  //     name: json['name'],
  //     imageUrl: '',
  //     types: json['types'].map((type) => type['type']['name']).toList(),
  //   );
  // }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<dynamic> typesJson = json['types'];
    List<String> types = typesJson.map((type) => type['type']['name'].toString()).toList();

    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: '',
      types: types,
    );
  }
}
