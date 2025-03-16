import 'package:bloc/bloc.dart';
import 'package:characters_list_app/core/constants/app_constans.dart';
import 'package:characters_list_app/features/characters_page/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/usecases/get_characters_page.dart';
import '../../domain/usecases/params/characters_params.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharactersPageBloc
    extends Bloc<CharactersPageEvent, CharactersPageState> {
  final GetCharactersPage getCharactersPage;

  CharactersPageBloc({required this.getCharactersPage})
    : super(
        const CharactersPageLoaded(charactersList: [], hasReachedMax: false),
      ) {
    on<CharactersPageLoad>(
      _getCharactersList,
      transformer: debounce(DEBOUNCE_DURATION),
    );
  }

  Future<void> _getCharactersList(
    CharactersPageLoad event,
    Emitter<CharactersPageState> emit,
  ) async {
    final currentState = state;

    if (currentState is CharactersPageLoaded && currentState.hasReachedMax) {
      return;
    }

    final List<CharacterEntity> oldCharacters =
        currentState is CharactersPageLoaded ? currentState.charactersList : [];

    final nextPage = (oldCharacters.length ~/ 20) + 1;

    final failureOrCharacters = await getCharactersPage(
      CharactersPageParams(pageNumber: nextPage),
    );

    failureOrCharacters.fold(
      (failure) => emit(
        CharactersPageFailure(
          message: failure.message,
          charactersList: oldCharacters,
        ),
      ),
      (charactersPage) {
        final newCharacters = charactersPage.characters;
        final hasReachedMax = charactersPage.next == null;

        emit(
          CharactersPageLoaded(
            charactersList: [...oldCharacters, ...newCharacters],
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  static EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
