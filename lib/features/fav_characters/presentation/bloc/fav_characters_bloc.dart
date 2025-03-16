import 'package:bloc/bloc.dart';
import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';
import 'package:characters_list_app/features/fav_characters/domain/usecases/params/character_filter_params.dart';
import 'package:characters_list_app/features/fav_characters/domain/usecases/params/character_params.dart';
import 'package:characters_list_app/injection_container/injection_container_export.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';

part 'fav_characters_event.dart';
part 'fav_characters_state.dart';

class FavCharactersBloc extends Bloc<FavCharactersEvent, FavCharactersState> {
  final GetAllCharacters getAllCharacters;
  final ToggleFavoriteCharacter toggleFavoriteCharacter;
  final UpdateCharacter updateCharacter;

  FavCharactersBloc({
    required this.getAllCharacters,
    required this.toggleFavoriteCharacter,
    required this.updateCharacter,
  }) : super(const FavCharactersLoaded(favCharactersList: [])) {
    on<FavCharactersLoad>(_getAllFavCharacters);
    on<FavCharacterToggle>(_toggleFavCharacter);
    on<FavCharacterUpdate>(_updateFavCharacter);
  }

  Future<void> _getAllFavCharacters(
    FavCharactersLoad event,
    Emitter<FavCharactersState> emit,
  ) async {
    final failureOrFavCharactersList = await getAllCharacters(
      CharacterFilterParams(
        name: event.name,
        status: event.status,
        species: event.species,
        type: event.type,
      ),
    );
    failureOrFavCharactersList.fold(
      (failure) => emit(FavCharactersFailure(message: failure.message)),
      (favCharactersList) =>
          emit(FavCharactersLoaded(favCharactersList: favCharactersList)),
    );
  }

  Future<void> _toggleFavCharacter(
    FavCharacterToggle event,
    Emitter<FavCharactersState> emit,
  ) async {
    final failureOrSucces = await toggleFavoriteCharacter(
      CharacterParams(character: event.character),
    );
    _handleCharacterChange(failureOrSucces, emit);
  }

  Future<void> _updateFavCharacter(
    FavCharacterUpdate event,
    Emitter<FavCharactersState> emit,
  ) async {
    final failureOrSucces = await updateCharacter(
      CharacterParams(character: event.character),
    );
    _handleCharacterChange(failureOrSucces, emit);
  }

  void _handleCharacterChange(
    Either<Failure, void> result,
    Emitter<FavCharactersState> emit,
  ) {
    result.fold(
      (failure) => emit(FavCharactersFailure(message: failure.message)),
      (_) async {
        emit(FavCharactersChanged());
        add(FavCharactersLoad());
      },
    );
  }
}
