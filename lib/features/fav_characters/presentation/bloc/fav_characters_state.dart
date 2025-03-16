part of 'fav_characters_bloc.dart';

abstract class FavCharactersState extends Equatable {
  final List<CharacterEntity> favCharactersList;
  const FavCharactersState({this.favCharactersList = const []});

  @override
  List<Object> get props => [favCharactersList];
}

class FavCharactersInitial extends FavCharactersState {}

class FavCharactersChanged extends FavCharactersState {}

class FavCharactersLoaded extends FavCharactersState {
  const FavCharactersLoaded({required super.favCharactersList});
}

class FavCharactersFailure extends FavCharactersState {
  final String message;

  const FavCharactersFailure({required this.message});

  @override
  List<Object> get props => [message];
}
