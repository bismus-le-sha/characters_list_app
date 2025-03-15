import 'package:characters_list_app/core/error/failures.dart';
import 'package:characters_list_app/core/usecase/usecase.dart';
import 'package:characters_list_app/features/character/domain/entities/page_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/character_repository.dart';
import 'params/characters_params.dart';

class GetCharactersPage implements UseCase<PageEntity, CharactersParams> {
  final CharacterRepository repository;

  GetCharactersPage(this.repository);

  @override
  Future<Either<Failure, PageEntity>> call(CharactersParams params) async {
    return repository.getPage(params.page);
  }
}
