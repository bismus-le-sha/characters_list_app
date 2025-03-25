import 'package:auto_route/annotations.dart';
import 'package:characters_list_app/features/fav_characters/presentation/widgets/fav_character_display.dart';
import 'package:characters_list_app/features/fav_characters/presentation/widgets/sort_dropdown_menu.dart';
import 'package:characters_list_app/injection_container/injection_container_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../characters_page/presentation/widgets/characters_failure_display.dart';
import '../cubit/sort_characters_cubit.dart';

@RoutePage()
class FavCharactersPage extends StatelessWidget {
  const FavCharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavCharactersBloc>().add(FavCharactersLoad());

    return Scaffold(
      appBar: AppBar(actions: [SortDropdownMenu()]),
      body: SafeArea(
        child: BlocBuilder<FavCharactersBloc, FavCharactersState>(
          builder: (context, state) {
            if (state is FavCharactersInitial) {
              return const CharactersLoadingDisplay();
            }
            if (state is FavCharactersLoaded) {
              if (state.favCharactersList.isEmpty) {
                return const Center(
                  child: Text('We didn’t find any characters'),
                );
              }

              context.read<FavCharactersSortingCubit>().loadCharacters(
                state.favCharactersList,
              );

              return const FavCharacterDisplay();
            }
            if (state is FavCharactersFailure) {
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
