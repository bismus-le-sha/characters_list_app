import 'package:characters_list_app/core/error/failures.dart';
import 'package:characters_list_app/core/usecase/usecase.dart';
import 'package:characters_list_app/features/characters_page/domain/entities/page_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/character_repository.dart';
import 'params/characters_page_params.dart';

class GetCharactersPage
    implements UseCase<CharactersPageEntity, CharactersPageParams> {
  final CharactersPageRepository repository;

  GetCharactersPage(this.repository);

  @override
  Future<Either<Failure, CharactersPageEntity>> call(
    CharactersPageParams params,
  ) async {
    return repository.getPage(params.pageNumber);
  }
}
