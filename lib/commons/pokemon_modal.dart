import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/resources/themes.dart';
import 'package:pokedex_app/views/pokemon_details_view.dart';

class PokemonDetailsModal extends StatelessWidget {
  final Pokemon pokemon;
  String _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  const PokemonDetailsModal({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: Text(
              _capitalizeFirstLetter('${pokemon.name} #${pokemon.id.toString().padLeft(3, '0')}'),
            ),
            backgroundColor: mainBackground,
          ),
          PokemonDetailsView(pokemon: pokemon)
        ],
      ),
    );
  }
}
