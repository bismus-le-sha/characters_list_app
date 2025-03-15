import 'package:bloc/bloc.dart';
import 'package:characters_list_app/features/character/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_characters_page.dart';
import '../../domain/usecases/params/characters_params.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharactersPage getCharactersPage;

  CharacterBloc({required this.getCharactersPage})
    : super(const CharactersLoaded(characters: [], hasReachedMax: false)) {
    on<CharactersLoad>(_getCharactersList);
  }

  Future<void> _getCharactersList(
    CharactersLoad event,
    Emitter<CharacterState> emit,
  ) async {
    final currentState = state;

    if (currentState is CharactersLoaded && currentState.hasReachedMax) return;

    final oldCharacters =
        currentState is CharactersLoaded ? currentState.characters : [];

    final nextPage = (oldCharacters.length ~/ 20) + 1;

    final failureOrCharacters = await getCharactersPage(
      CharactersParams(page: nextPage),
    );

    failureOrCharacters.fold(
      (failure) => emit(CharacterFailure(message: failure.message)),
      (charactersPage) {
        final newCharacters = charactersPage.characters;
        final hasReachedMax = charactersPage.next == null;

        emit(
          CharactersLoaded(
            characters: [...oldCharacters, ...newCharacters],
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }
}
