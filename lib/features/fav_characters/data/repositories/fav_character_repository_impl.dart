import 'package:characters_list_app/core/error/exceptions.dart';
import 'package:characters_list_app/core/error/failures.dart';
import 'package:characters_list_app/features/fav_characters/data/datasources/fav_characters_datasource.dart';

import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';

import 'package:characters_list_app/features/fav_characters/domain/usecases/params/character_filter_params.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/fav_characters_repository.dart';

class FavCharactersRepositoryImpl implements FavCharactersRepository {
  final FavCharactersDatasource datasource;

  FavCharactersRepositoryImpl({required this.datasource});

  Future<Either<Failure, void>> _addCharacter(CharacterEntity character) async {
    try {
      return Right(await datasource.addCharacter(character));
    } on CharacterAlreadyExistException {
      return Left(Failure.fromType(FailureType.characterAlreadyExistError));
    }
  }

  Future<Either<Failure, void>> _deleteCharacter(
    CharacterEntity character,
  ) async {
    try {
      return Right(await datasource.deleteCharacter(character));
    } on CharacterNotExistException {
      return Left(Failure.fromType(FailureType.characterNotExistError));
    }
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(
    CharacterFilterParams params,
  ) async {
    final charactersModels = await datasource.getAllCharacters(
      params.name,
      params.status,
      params.species,
      params.type,
    );

    final charactersEntityList =
        charactersModels.map((model) => model.toEntity()).toList();
    return Right(charactersEntityList);
  }

  @override
  Future<Either<Failure, void>> updateCharacter(
    CharacterEntity character,
  ) async {
    try {
      return Right(await datasource.updateCharacter(character));
    } on CharacterNotExistException {
      return Left(Failure.fromType(FailureType.characterNotExistError));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavoriteCharacter(
    CharacterEntity character,
  ) async {
    try {
      return (await datasource.isFavCharacter(character))
          ? _deleteCharacter(character)
          : _addCharacter(character);
    } catch (e) {
      return Left(
        Failure.fromType(FailureType.favoriteCharacterOperationError),
      );
    }
  }
}
