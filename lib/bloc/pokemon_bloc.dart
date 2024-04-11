import 'package:flutter_bloc/flutter_bloc.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';
import 'package:pokedex_app/services/pokemon_service.dart';
import 'package:pokedex_app/resources/constants.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonService _pokemonService;

  PokemonBloc(this._pokemonService) : super(PokemonInitial()) {
    on<FetchPokemons>((event, emit) async {
      emit(const PokemonLoading([]));
      try {
        final pokemons = await _pokemonService.fetchPokemons(offset: event.offset);
        emit(PokemonLoaded(pokemons, hasMore: pokemons.length > 10));
      } catch (e) {
        emit(const PokemonError(errorText));
      }
    });
  }
}
