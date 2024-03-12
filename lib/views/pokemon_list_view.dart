import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/views/error_view.dart';
import 'package:pokedex_app/widgets/pikachu_loading.dart';
import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_event.dart';
import '../bloc/pokemon_state.dart';
import '../models/pokemon_model.dart';
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
  List<Pokemon> displayedPokemonList = [];
  bool showRefreshIndicator = false;

  @override
  void initState() {
    super.initState();
    pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    pokemonBloc.add(FetchPokemons());
    scrollController.addListener(() {
      if (!isLoading &&
          scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _refreshPokemons();
      }
    });
    pokemonBloc.stream.listen((state) {
      if (state is PokemonLoaded) {
        setState(() {
          displayedPokemonList.addAll(state.pokemons);
          isLoading = false;
          showRefreshIndicator = false;
        });
      } else if (state is PokemonLoading) {
        setState(() {
          isLoading = true;
          showRefreshIndicator = true;
        });
      }
    });
  }

  Future<void> _refreshPokemons() async {
    setState(() {
      isLoading = true;
      showRefreshIndicator = true;
    });
    pokemonBloc.add(FetchPokemons());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex - Daniel Alvarez')),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading && displayedPokemonList.isEmpty) {
            return const Center(child: PikachuLoading());
          } else if (state is PokemonError) {
            return ErrorView(errorMessage: state.message);
          } else {
            return Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  itemCount: displayedPokemonList.length,
                  itemBuilder: (context, index) {
                    final pokemon = displayedPokemonList[index];
                    return PokemonListItem(pokemon: pokemon);
                  },
                ),
                if (showRefreshIndicator)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white,
                      child: const PikachuLoading(),
                    ),
                  ),
              ],
            );
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
