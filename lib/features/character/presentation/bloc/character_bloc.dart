import 'package:bloc/bloc.dart';
import 'package:characters_list_app/features/character/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_characters_page.dart';
import '../../domain/usecases/params/characters_params.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharactersPage getCharactersPage;
  int currentPage = 1;
  bool hasReachedMax = false;
  final List<CharacterEntity> charactersList = [];

  CharacterBloc({required this.getCharactersPage}) : super(CharacterInitial()) {
    on<CharactersLoad>(_getCharactersList);
  }

  Future<void> _getCharactersList(
    CharactersLoad event,
    Emitter<CharacterState> emit,
  ) async {
    if (hasReachedMax || state is CharacterLoading) return;

    final currentState = state;
    List<CharacterEntity> oldCharacters = [];
    if (currentState is CharactersLoaded) {
      oldCharacters = currentState.characters;
    }

    emit(CharacterLoading(oldCharacters, isFirstFetch: currentPage == 1));

    final failureOrCharacters = await getCharactersPage(
      CharactersParams(page: currentPage),
    );

    failureOrCharacters.fold(
      (failure) => emit(CharacterFailure(message: failure.toString())),
      (charactersPage) {
        final newCharacters = charactersPage.characters;
        hasReachedMax = charactersPage.next == null;
        currentPage++;

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
