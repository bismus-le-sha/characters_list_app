part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {
  final List<CharacterEntity> oldCharacters;
  final bool isFirstFetch;

  const CharacterLoading(this.oldCharacters, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldCharacters, isFirstFetch];
}

class CharactersLoaded extends CharacterState {
  final List<CharacterEntity> characters;
  final bool hasReachedMax;

  const CharactersLoaded({
    required this.characters,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [characters, hasReachedMax];
}

class CharacterFailure extends CharacterState {
  final String message;

  const CharacterFailure({required this.message});

  @override
  List<Object> get props => [message];
}
