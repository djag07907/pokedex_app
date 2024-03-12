import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/widgets/pikachu_loading.dart';
import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import '../bloc/pokemon_state.dart';
import '../widgets/pokemon_list_item.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({Key? key}) : super(key: key);

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
                    itemCount: state.pokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = state.pokemons[index];
                      return PokemonListItem(pokemon: pokemon);
                    },
                  ),
                ),
                if (state.hasMore) const PikachuLoading()
              ],
            );
          } else if (state is PokemonError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () => context.read<PokemonBloc>().add(FetchPokemons()),
                    child: const Text('Try Again'),
                  ),
                  Image.asset('images/sad_pikachu.png'),
                ],
              ),
            );
          } else {
            return Text('Current state: $state');
          }
        },
      ),
    );
  }
}
