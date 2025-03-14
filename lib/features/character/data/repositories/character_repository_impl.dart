import 'package:characters_list_app/core/error/failures.dart';
import 'package:characters_list_app/features/character/data/datasources/local_character_datasource.dart';

import 'package:characters_list_app/features/character/domain/entities/page_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/remote_character_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final RemoteCharacterDataSource remoteDataSource;
  final LocalCharacterDataSource localDataSource;
  final NetworkInfo networkInfo;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PageEntity>> getPage(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacters = await remoteDataSource.getPage(page);
        localDataSource.cachePage(remoteCharacters, page);
        return Right(remoteCharacters);
      } on ServerException {
        return Left(Failure.fromType(FailureType.serverError));
      }
    } else {
      try {
        final localCharacters = await localDataSource.getLastCharacters(page);
        return Right(localCharacters);
      } on CacheException {
        return Left(Failure.fromType(FailureType.cacheError));
      }
    }
  }
}
