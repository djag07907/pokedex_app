import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/pokemon_repository.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;

  PokemonBloc(this._pokemonRepository) : super(PokemonInitial()) {
    on<FetchPokemons>((event, emit) async {
      emit(PokemonLoading());
      try {
        final pokemons = await _pokemonRepository.fetchPokemons();
        emit(PokemonLoaded(pokemons));
      } catch (e) {
        emit(PokemonError("Something went wrong: $e"));
      }
    });
  }
}
