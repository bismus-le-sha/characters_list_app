import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';

class CharactersPageEntity extends Equatable {
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  final List<CharacterEntity> characters;

  const CharactersPageEntity({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
    required this.characters,
  });

  @override
  List<Object?> get props => [count, pages, next, prev, characters];
}
