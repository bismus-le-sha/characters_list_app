part of 'character_bloc.dart';

abstract class CharactersPageState extends Equatable {
  final List<CharacterEntity> charactersList;
  final bool hasReachedMax;
  final int page;

  const CharactersPageState({
    this.charactersList = const [],
    this.hasReachedMax = false,
    this.page = 0,
  });

  @override
  List<Object> get props => [charactersList, hasReachedMax, page];
}

class CharactersPageLoading extends CharactersPageState {}

class CharactersPageLoaded extends CharactersPageState {
  const CharactersPageLoaded({
    required super.charactersList,
    required super.hasReachedMax,
    required super.page,
  });
}

class CharactersPageFailure extends CharactersPageState {
  final String message;

  const CharactersPageFailure({
    required this.message,
    required super.charactersList,
    required super.page,
  });

  @override
  List<Object> get props => [message, charactersList, page];
}
