part of 'fav_characters_bloc.dart';

abstract class FavCharactersEvent extends Equatable {
  const FavCharactersEvent();

  @override
  List<Object?> get props => [];
}

class FavCharactersLoad extends FavCharactersEvent {
  final String? name;
  final String? status;
  final String? species;
  final String? type;

  const FavCharactersLoad({this.name, this.status, this.species, this.type});
  @override
  List<Object?> get props => [name, status, species, type];
}

class FavCharacterUpdate extends FavCharactersEvent {
  final CharacterEntity character;

  const FavCharacterUpdate(this.character);

  @override
  List<Object> get props => [character];
}

class FavCharacterToggle extends FavCharactersEvent {
  final CharacterEntity character;

  const FavCharacterToggle(this.character);

  @override
  List<Object> get props => [character];
}
