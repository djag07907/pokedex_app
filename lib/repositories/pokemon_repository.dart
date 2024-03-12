import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonRepository {
  final baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  int offset = 0;
  int limit = 1302; //Current number of total pokemon @ march/12/2024

  Future<List<Pokemon>> fetchPokemons() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?offset=$offset&limit=$limit'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> pokemonsJson = data['results'];
        List<Pokemon> pokemons = pokemonsJson.map((json) {
          String name = json['name'];
          int id = int.parse(json['url'].split('/').reversed.elementAt(1));
          String imageUrl =
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";
          return Pokemon(id: id, name: name, imageUrl: imageUrl);
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
