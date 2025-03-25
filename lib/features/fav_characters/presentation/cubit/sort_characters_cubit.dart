import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/util/character/fav_characters_sort_type.dart';
import '../../domain/entities/character_entity.dart';

part 'sort_characters_state.dart';

class FavCharactersSortingCubit extends Cubit<FavCharactersSortingState> {
  FavCharactersSortingCubit() : super(FavCharactersSortingInitial());

  void loadCharacters(List<CharacterEntity> characters) {
    emit(
      FavCharactersSortingLoaded(
        sortedList: characters,
        sortType: SortType.defaultOrder,
      ),
    );
  }

  void sortCharacters(List<CharacterEntity> characters, SortType sortType) {
    List<CharacterEntity> sortedList = List.from(characters);

    switch (sortType) {
      case SortType.byName:
        sortedList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortType.bySpecies:
        sortedList.sort((a, b) => a.species.compareTo(b.species));
        break;
      case SortType.byStatus:
        sortedList.sort((a, b) => a.status.compareTo(b.status));
        break;
      case SortType.byType:
        sortedList.sort((a, b) => a.type.compareTo(b.type));
        break;
      case SortType.defaultOrder:
        break;
    }
    emit(
      FavCharactersSortingLoaded(sortedList: sortedList, sortType: sortType),
    );
  }
}
