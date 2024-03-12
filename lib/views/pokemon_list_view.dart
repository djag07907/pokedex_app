import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/views/error_view.dart';
import 'package:pokedex_app/widgets/pikachu_loading.dart';
import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_state.dart';
import '../widgets/pokemon_list_item.dart';

class PokemonListView extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  PokemonListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading && state.pokemons.isEmpty) {
            return const Center(child: PikachuLoading());
          } else if (state is PokemonLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: state.pokemons.length + (state.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < state.pokemons.length) {
                        final pokemon = state.pokemons[index];
                        return PokemonListItem(pokemon: pokemon);
                      } else {
                        return const PikachuLoading();
                      }
                    },
                    addAutomaticKeepAlives: true,
                  ),
                ),
              ],
            );
          } else if (state is PokemonError) {
            return ErrorView(errorMessage: state.message);
          } else {
            return Text('Current state: $state');
          }
        },
      ),
    );
  }
}
