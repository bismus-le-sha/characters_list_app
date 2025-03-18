import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/widgets/character_card.dart';

class FavCharacterDisplay extends StatelessWidget {
  final List<CharacterEntity> favCharactersList;
  const FavCharacterDisplay({super.key, required this.favCharactersList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: favCharactersList.length,
        itemBuilder: (context, index) {
          return CharacterCard(character: favCharactersList[index]);
        },
      ),
    );
  }
}
