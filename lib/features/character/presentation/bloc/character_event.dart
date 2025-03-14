part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class CharactersLoad extends CharacterEvent {}

class CharactersRefresh extends CharacterEvent {}
