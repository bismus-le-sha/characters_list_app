import 'package:characters_list_app/core/error/failures.dart';
import 'package:characters_list_app/core/usecase/usecase.dart';
import 'package:characters_list_app/features/fav_characters/domain/usecases/params/character_filter_params.dart';
import 'package:dartz/dartz.dart';

import '../entities/character_entity.dart';
import '../repositories/fav_characters_repository.dart';

class GetAllCharacters
    implements UseCase<List<CharacterEntity>, CharacterFilterParams> {
  final FavCharactersRepository repository;

  GetAllCharacters(this.repository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(
    CharacterFilterParams params,
  ) async {
    return repository.getAllCharacters(params);
  }
}
