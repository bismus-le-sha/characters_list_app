import 'package:auto_route/annotations.dart';
import 'package:characters_list_app/features/characters_page/presentation/bloc/character_bloc.dart';
import 'package:characters_list_app/features/characters_page/presentation/widgets/characters_display.dart';
import 'package:characters_list_app/features/characters_page/presentation/widgets/characters_failure_display.dart';
import 'package:characters_list_app/features/characters_page/presentation/widgets/theme_toglge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CharactersPageBloc>().add(CharactersPageLoad());
    return Scaffold(
      appBar: AppBar(actions: [ThemeToggle()]),
      body: SafeArea(
        child: BlocBuilder<CharactersPageBloc, CharactersPageState>(
          builder: (context, state) {
            if (state is CharactersPageInitial) {
              return CharactersLoadingDisplay();
            }
            if (state is CharactersPageLoaded) {
              return CharactersDisplay(
                characters: state.charactersList,
                hasReachedMax: state.hasReachedMax,
              );
            }
            if (state is CharactersPageFailure) {
              if (state.charactersList.isEmpty) {
                return CharactersFailureDisplay(failureMessage: state.message);
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
