import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/resources/themes.dart';

class PokemonDetailsView extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailsView({super.key, required this.pokemon});

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

Color getColorForType(String type) {
  switch (type) {
    case 'grass':
      return grassBackground;
    case 'fire':
      return fireBackground;
    case 'water':
      return waterBackground;
    case 'electric':
      return electricBackground;
    case 'poison':
      return poisonBackground;
    case 'bug':
      return bugBackground;
    case 'normal':
      return normalBackground;
    case 'fighting':
      return fightingBackground;
    case 'ground':
      return groundBackground;
    case 'fairy':
      return fairyBackground;
    case 'psychic':
      return psychicBackground;
    case 'rock':
      return rockBackground;
    case 'ghost':
      return ghostBackground;
    case 'ice':
      return iceBackground;
    case 'dragon':
      return dragonBackground;
    case 'dark':
      return rockBackground;
    case 'steel':
      return steelBackground;
    case 'flying':
      return flyingBackground;
    default:
      return Colors.grey;
  }
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              widget.pokemon.imageUrl,
              width: 100,
              height: 100,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.pokemon.types
                  .map(
                    (type) => ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: getColorForType(type),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
                          color: white,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
