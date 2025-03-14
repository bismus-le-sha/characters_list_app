import 'package:characters_list_app/features/character/presentation/bloc/character_bloc.dart';
import 'package:characters_list_app/features/character/presentation/widgets/characters_display.dart';
import 'package:characters_list_app/features/character/presentation/widgets/characters_failure_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CharacterBloc>().add(CharactersLoad());
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharacterInitial) {
              return CharactersLoadingDisplay();
            }
            if (state is CharactersLoaded) {
              return CharactersDisplay(
                characters: state.characters,
                hasReachedMax: state.hasReachedMax,
              );
            }
            if (state is CharacterFailure) {
              return CharactersFailureDisplay(failureMessage: state.message);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
