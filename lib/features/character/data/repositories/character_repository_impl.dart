import 'package:characters_list_app/core/error/failures.dart';
import 'package:characters_list_app/features/character/data/datasources/local_character_datasource.dart';
import 'package:characters_list_app/features/character/domain/entities/page_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/remote_character_datasource.dart';
import 'package:flutter/foundation.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final RemoteCharacterDataSource remoteDataSource;
  final LocalCharacterDataSource localDataSource;
  final NetworkInfo networkInfo;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  Future<void> _updateCacheIfNeeded(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePages = await remoteDataSource.getPage(page);
        await localDataSource.cachePage(remotePages);
      } catch (_) {
        debugPrint("Error while updating cache for page $page");
      }
    }
  }

  Future<Either<Failure, PageEntity>> _getRemotePageAndCache(int page) async {
    try {
      final remotePages = await remoteDataSource.getPage(page);
      await localDataSource.cachePage(remotePages);
      return Right(remotePages.toEntity());
    } on ServerException {
      debugPrint("Error while fetching remote data for page $page");
      return Left(Failure.fromType(FailureType.serverError));
    }
  }

  Future<Either<Failure, PageEntity>> _handleCacheError(int page) async {
    if (await networkInfo.isConnected) {
      return await _getRemotePageAndCache(page);
    }
    return Left(Failure.fromType(FailureType.connectionError));
  }

  @override
  Future<Either<Failure, PageEntity>> getPage(int page) async {
    final isCacheAvailable = await localDataSource.isCacheNotEmpty();

    if (isCacheAvailable) {
      try {
        final localPages = await localDataSource.getCachedPages(page);
        _updateCacheIfNeeded(page);
        return Right(localPages.toEntity());
      } on CacheException {
        return await _handleCacheError(page);
      }
    }

    return Left(Failure.fromType(FailureType.cacheEmpty));
  }
}
