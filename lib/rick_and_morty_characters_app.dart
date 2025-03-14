import 'package:characters_list_app/features/character/presentation/bloc/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/character/presentation/pages/character_page.dart';
import 'injection_container.dart' as di;

class RickAndMortyCharactersApp extends StatelessWidget {
  const RickAndMortyCharactersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<CharacterBloc>(),
      child: MaterialApp(home: CharactersPage()),
    );
  }
}
