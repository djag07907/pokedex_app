import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/repositories/pokemon_repository.dart';

class PokemonService {
  Future<List<Pokemon>> fetchPokemons({int offset = 0}) async {
    final repository = PokemonRepository();
    return repository.fetchPokemons(offset: offset);
  }
}
