import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/resources/api_endpoints.dart';

class PokemonRepository {
  int limit = 10;

  Future<List<Pokemon>> fetchPokemons({int offset = 0}) async {
    try {
      final response = await http.get(Uri.parse('$pokemonList?offset=$offset&limit=$limit'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> pokemonsJson = data['results'];
        List<Pokemon> pokemons = pokemonsJson.map((json) {
          String name = json['name'];
          int id = int.parse(json['url'].split('/').reversed.elementAt(1));
          String imageUrl = getPokemonImageUrl(id);

          List<String> types = [];
          if (json.containsKey('types') && json['types'] != null) {
            types = (json['types'] as List<dynamic>).map((type) {
              return type['type']['name'].toString();
            }).toList();
          }

          return Pokemon(id: id, name: name, imageUrl: imageUrl, types: types);
        }).toList();

        if (kDebugMode) {
          print('Pokemons loaded successfully: ${pokemons.length} pokemons');
        }

        offset += limit;
        return pokemons;
      } else if (response.statusCode == 400) {
        throw Exception('Pokemon not found');
      } else {
        if (kDebugMode) {
          print('Failed to load pokemons. Status code: ${response.statusCode}');
        }
        throw Exception('Failed to load pokemons: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Network error: $e');
      }
      throw Exception('Failed to fetch pokemons. Please check your internet connection');
    }
  }
}
