import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/bloc/pokemon_event.dart';
import 'bloc/pokemon_bloc.dart';
import 'repositories/pokemon_repository.dart';
import 'views/pokemon_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: BlocProvider(
        create: (context) => PokemonBloc(PokemonRepository())..add(FetchPokemons()),
        child: const PokemonListView(),
      ),
    );
  }
}
