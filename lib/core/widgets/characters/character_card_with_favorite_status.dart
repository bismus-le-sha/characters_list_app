import 'package:characters_list_app/core/widgets/characters/character_card.dart';
import 'package:characters_list_app/core/widgets/characters/models/character_card_data_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/fav_characters/domain/entities/character_entity.dart';
import '../../../features/fav_characters/presentation/bloc/fav_characters_bloc.dart';

class CharacterCardWithFavoriteStatus extends StatelessWidget {
  final CharacterEntity character;
  final String pageViewTag;
  final double height;

  const CharacterCardWithFavoriteStatus({
    super.key,
    required this.character,
    required this.pageViewTag,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavCharactersBloc, FavCharactersState, bool>(
      selector: (state) {
        return state.favCharactersList.contains(character);
      },
      builder: (context, isFavorite) {
        return CharacterCardGesture(
          characterCardData: CharacterCardData(
            character: character,
            pageViewTag: pageViewTag,
            isFavorite: isFavorite,
            height: height,
          ),
        );
      },
    );
  }
}
