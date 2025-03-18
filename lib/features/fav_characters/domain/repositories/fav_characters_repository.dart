import 'package:characters_list_app/core/error/failures.dart';
import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';

import 'package:dartz/dartz.dart';

import '../usecases/params/character_filter_params.dart';

abstract class FavCharactersRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(
    CharacterFilterParams params,
  );
  Future<Either<Failure, void>> updateCharacter(CharacterEntity character);
  Future<Either<Failure, void>> toggleFavoriteCharacter(
    CharacterEntity character,
  );
}
