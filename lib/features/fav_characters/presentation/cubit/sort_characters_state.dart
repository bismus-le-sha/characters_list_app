part of 'sort_characters_cubit.dart';

sealed class FavCharactersSortingState extends Equatable {
  const FavCharactersSortingState();

  @override
  List<Object> get props => [];
}

final class FavCharactersSortingInitial extends FavCharactersSortingState {}

final class FavCharactersSortingLoaded extends FavCharactersSortingState {
  final List<CharacterEntity> sortedList;
  final SortType sortType;

  const FavCharactersSortingLoaded({
    required this.sortedList,
    required this.sortType,
  });

  @override
  List<Object> get props => [sortedList, sortType];
}
