import 'package:characters_list_app/core/constants/app_constans.dart';
import 'package:characters_list_app/core/widgets/characters/character_card_with_favorite_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/sort_characters_cubit.dart';

class FavCharacterDisplay extends StatelessWidget {
  const FavCharacterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.2;
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
                  pageViewTag: favDisplayTag,
                  height: height,
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
