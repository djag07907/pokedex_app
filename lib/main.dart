import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/services/pokemon_service.dart';
import 'package:pokedex_app/views/pokemon_list_view.dart';

void main() {
  final PokemonBloc pokemonBloc = PokemonBloc(PokemonService());
  runApp(MyApp(pokemonBloc: pokemonBloc));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.pokemonBloc}) : super(key: key);

  final PokemonBloc pokemonBloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: BlocProvider.value(
        value: pokemonBloc,
        child: const PokemonListView(),
      ),
    );
  }
}
