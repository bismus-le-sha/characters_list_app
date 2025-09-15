import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_characters_page.dart';
import '../../domain/usecases/params/characters_page_params.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharactersPageBloc
    extends Bloc<CharactersPageEvent, CharactersPageState> {
  final GetCharactersPage getCharactersPage;

  CharactersPageBloc({required this.getCharactersPage})
    : super(CharactersPageLoading()) {
    on<CharactersPageLoad>(_onFetch);
    on<CharactersPageLoadMore>(_onFetchMore, transformer: droppable());

    if (state is CharactersPageLoading) add(CharactersPageLoad());
  }

  Future<void> _onFetch(
    CharactersPageLoad event,
    Emitter<CharactersPageState> emit,
  ) async {
    final failureOrCharacters = await getCharactersPage(
      CharactersPageParams(pageNumber: 1),
    );

    failureOrCharacters.fold(
      (failure) => emit(
        CharactersPageFailure(
          message: failure.message,
          charactersList: state.charactersList,
          page: 0,
        ),
      ),
      (charactersPage) {
        emit(
          CharactersPageLoaded(
            charactersList: charactersPage.characters,
            hasReachedMax: charactersPage.next == null,
            page: 1,
          ),
        );
      },
    );
  }

  Future<void> _onFetchMore(
    CharactersPageLoadMore event,
    Emitter<CharactersPageState> emit,
  ) async {
    final currentState = state;
    if (currentState is! CharactersPageLoaded || currentState.hasReachedMax) {
      return;
    }

    final nextPage = currentState.page + 1;

    final failureOrCharacters = await getCharactersPage(
      CharactersPageParams(pageNumber: nextPage),
    );

    failureOrCharacters.fold(
      (failure) => emit(
        CharactersPageFailure(
          message: failure.message,
          charactersList: currentState.charactersList,
          page: currentState.page,
        ),
      ),
      (charactersPage) {
        emit(
          CharactersPageLoaded(
            charactersList: [
              ...currentState.charactersList,
              ...charactersPage.characters,
            ],
            hasReachedMax: charactersPage.next == null,
            page: nextPage,
          ),
        );
      },
    );
  }
}
