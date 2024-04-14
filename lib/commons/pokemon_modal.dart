import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';

class PokemonDetailsModal extends StatelessWidget {
  final Pokemon pokemon;

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
              '${pokemon.name} #${pokemon.id}',
            ),
          ),
        ],
      ),
    );
  }
}
