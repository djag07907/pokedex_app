import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEB2E52),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      // padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 220,
            height: 120,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/pink_pokeball.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Image.network(
              pokemon.imageUrl,
              width: 100,
              height: 100,
              // fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _capitalizeFirstLetter(pokemon.name),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }
}
