import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';

class CharacterCardData {
  final CharacterEntity character;
  final String pageViewTag;
  final bool isFavorite;
  final double height;

  CharacterCardData({
    required this.character,
    required this.pageViewTag,
    required this.isFavorite,
    required this.height,
  });

  String get heroTag => pageViewTag + character.name;
}
