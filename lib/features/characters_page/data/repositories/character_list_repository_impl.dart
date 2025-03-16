import 'package:characters_list_app/core/error/failures.dart';
import 'package:characters_list_app/features/characters_page/data/datasources/local_page_datasource.dart';
import 'package:characters_list_app/features/characters_page/domain/entities/page_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/remote_page_datasource.dart';
import 'package:flutter/foundation.dart';

class CharactersPageRepositoryImpl implements CharactersPageRepository {
  final RemoteCharactersPageDataSource remoteDataSource;
  final LocalCharactersPageDataSource localDataSource;
  final NetworkInfo networkInfo;

  CharactersPageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, bool>> _updateCacheIfNeeded(int pageNumber) async {
    try {
      final localPage = await localDataSource.getCachedPage(pageNumber);
      final remotePage = await remoteDataSource.getPage(pageNumber);

      if (localPage.etag != remotePage.etag) {
        await localDataSource.replaceCachedPage(remotePage);
        debugPrint("Cache updated for page $pageNumber.");
        return Right(true);
      }
      debugPrint("Cache is already up to date for page $pageNumber.");
      return Right(false);
    } catch (_) {
      debugPrint("Error while updating cache for page $pageNumber.");
      return Left(Failure.fromType(FailureType.cacheUpdateError));
    }
  }

  Future<Either<Failure, CharactersPageEntity>> _getRemotePageAndCache(
    int pageNumber,
  ) async {
    try {
      final remotePage = await remoteDataSource.getPage(pageNumber);
      await localDataSource.cachePage(remotePage);
      return Right(remotePage.toEntity());
    } on ServerException {
      debugPrint("Error while fetching remote data for page $pageNumber.");
      return Left(Failure.fromType(FailureType.serverError));
    }
  }

  Future<Either<Failure, CharactersPageEntity>> _handleCacheError(
    int pageNumber,
  ) async {
    if (await networkInfo.isConnected) {
      return _getRemotePageAndCache(pageNumber);
    }
    return Left(Failure.fromType(FailureType.connectionError));
  }

  @override
  Future<Either<Failure, CharactersPageEntity>> getPage(int pageNumber) async {
    if (await localDataSource.isCacheNotEmpty()) {
      try {
        final localPage = await localDataSource.getCachedPage(pageNumber);
        if (await networkInfo.isConnected) {
          _updateCacheIfNeeded(pageNumber);
        }
        return Right(localPage.toEntity());
      } on CacheException {
        return await _handleCacheError(pageNumber);
      }
    } else {
      return await _handleCacheError(pageNumber);
    }
  }
}
