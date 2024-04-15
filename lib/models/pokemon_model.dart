class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  Pokemon({required this.id, required this.name, required this.imageUrl, required this.types});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> types = (json['types'] as List<dynamic>).map((type) {
      return type['name'].toString();
    }).toList();
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: '',
      types: types,
    );
  }
}
