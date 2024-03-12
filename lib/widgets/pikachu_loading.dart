import 'package:flutter/material.dart';

class PikachuLoading extends StatelessWidget {
  const PikachuLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/loading.gif',
          width: 50,
          height: 50,
        ),
        const SizedBox(height: 10),
        const Text("Loading..."),
      ],
    );
  }
}
