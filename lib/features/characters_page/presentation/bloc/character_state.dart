part of 'character_bloc.dart';

abstract class CharactersPageState extends Equatable {
  final List<CharacterEntity> charactersList;
  final bool hasReachedMax;
  final bool isLoading;

  const CharactersPageState({
    this.charactersList = const [],
    this.hasReachedMax = false,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [charactersList, hasReachedMax, isLoading];
}

class CharactersPageInitial extends CharactersPageState {}

class CharactersPageLoaded extends CharactersPageState {
  const CharactersPageLoaded({
    required super.charactersList,
    required super.hasReachedMax,
    super.isLoading,
  });
}

class CharactersPageFailure extends CharactersPageState {
  final String message;

  const CharactersPageFailure({
    required this.message,
    required super.charactersList,
  }) : super();

  @override
  List<Object> get props => [message, charactersList];
}
