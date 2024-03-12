import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonRepository {
  final baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  int offset = 0;
  int limit = 7;

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse('$baseUrl?offset=$offset&limit=$limit'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> pokemonsJson = data['results'];
      List<Pokemon> pokemons = pokemonsJson.map((json) {
        String name = json['name'];
        int id = int.parse(json['url'].split('/').reversed.elementAt(1));
        return Pokemon(id: id, name: name);
      }).toList();
      print('Pokemons loaded successfully: ${pokemons.length} pokemons');
      offset += limit;
      return pokemons;
    } else {
      print('Failed to load pokemons. Status code: ${response.statusCode}');
      throw Exception('Failed to load pokemons: ${response.statusCode}');
    }
  }
}
