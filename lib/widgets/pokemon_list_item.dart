import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      child: Text(
        pokemon.name,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
