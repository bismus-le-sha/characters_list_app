part of 'character_bloc.dart';

abstract class CharactersPageEvent extends Equatable {
  const CharactersPageEvent();

  @override
  List<Object> get props => [];
}

class CharactersPageLoad extends CharactersPageEvent {}
