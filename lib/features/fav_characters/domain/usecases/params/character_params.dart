import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';

class CharacterParams extends Equatable {
  final CharacterEntity character;

  const CharacterParams({required this.character});

  @override
  List<Object?> get props => [character];
}
