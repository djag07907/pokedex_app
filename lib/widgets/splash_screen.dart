import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_app/views/pokemon_list_view.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const PokemonListView();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Lottie.asset('images/pokeball.json'),
        ),
      ),
    );
  }
}
