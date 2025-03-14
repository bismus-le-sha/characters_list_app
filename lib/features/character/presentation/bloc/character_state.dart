part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  final List<CharacterEntity> characters;
  final bool hasReachedMax;
  final bool isLoading;

  const CharacterState({
    this.characters = const [],
    this.hasReachedMax = false,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [characters, hasReachedMax, isLoading];
}

class CharacterInitial extends CharacterState {}

class CharactersLoaded extends CharacterState {
  const CharactersLoaded({
    required super.characters,
    required super.hasReachedMax,
    super.isLoading,
  });
}

class CharacterFailure extends CharacterState {
  final String message;

  const CharacterFailure({required this.message}) : super();

  @override
  List<Object> get props => [message, characters, hasReachedMax, isLoading];
}
