import 'package:characters_list_app/core/widgets/character_card_with_favorite_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/sort_characters_cubit.dart';

class FavCharacterDisplay extends StatelessWidget {
  const FavCharacterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: BlocBuilder<FavCharactersSortingCubit, FavCharactersSortingState>(
        builder: (context, state) {
          if (state is FavCharactersSortingLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: state.sortedList.length,
              itemBuilder: (context, index) {
                var character = state.sortedList[index];
                return CharacterCardWithFavoriteStatus(
                  key: ValueKey(character.name),
                  character: character,
                  pageViewTag: 'FCD',
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
