import 'package:flutter/material.dart';

class CharactersFailureDisplay extends StatelessWidget {
  const CharactersFailureDisplay({super.key, required this.failureMessage});
  final String failureMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(failureMessage)));
  }
}

class CharactersLoadingDisplay extends StatelessWidget {
  const CharactersLoadingDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: CircularProgressIndicator()));
  }
}
