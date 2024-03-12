import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/views/error_view.dart';
import 'package:pokedex_app/widgets/pikachu_loading.dart';
import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import '../bloc/pokemon_state.dart';
import '../widgets/pokemon_list_item.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({Key? key}) : super(key: key);

  @override
  _PokemonListViewState createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final ScrollController scrollController = ScrollController();
  late PokemonBloc pokemonBloc;
  int itemsPerPage = 10;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    pokemonBloc.add(FetchPokemons());

    scrollController.addListener(() {
      if (!isLoading &&
          scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        isLoading = true;
        pokemonBloc.add(FetchPokemons());
      }
    });

    pokemonBloc.stream.listen((state) {
      if (state is PokemonLoaded) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex - Daniel Alvarez')),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading && state.pokemons.isEmpty) {
            return const Center(child: PikachuLoading());
          } else if (state is PokemonLoaded) {
            final visiblePokemonCount = state.pokemons.length;
            final totalPokemonCount = state.pokemons.length + (state.hasMore ? 1 : 0);
            final displayedPokemon = state.pokemons.sublist(0,
                visiblePokemonCount < totalPokemonCount ? visiblePokemonCount : totalPokemonCount);

            return ListView.builder(
              controller: scrollController,
              itemCount: displayedPokemon.length + (state.hasMore && !isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < displayedPokemon.length) {
                  final pokemon = displayedPokemon[index];
                  return PokemonListItem(pokemon: pokemon);
                } else if (state.hasMore && !isLoading) {
                  isLoading = true;
                  pokemonBloc.add(FetchPokemons());
                  return const PikachuLoading();
                } else {
                  return const SizedBox();
                }
              },
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
