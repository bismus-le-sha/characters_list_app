import 'dart:async';

import 'package:characters_list_app/core/error/failures.dart';
import 'package:characters_list_app/features/characters_page/data/datasources/local_page_datasource.dart';
import 'package:characters_list_app/features/characters_page/domain/entities/page_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/remote_page_datasource.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CharactersPageRepositoryImpl implements CharactersPageRepository {
  final RemoteCharactersPageDataSource remoteDataSource;
  final LocalCharactersPageDataSource localDataSource;
  final NetworkInfo networkInfo;
  final Talker? talker;

  CharactersPageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    this.talker,
  });

  @override
  Future<Either<Failure, CharactersPageEntity>> getPage(int pageNumber) async {
    try {
      final localPage = await localDataSource.getCachedPage(pageNumber);
      final entity = localPage.toEntity();

      if (await networkInfo.isConnected &&
          await localDataSource.isCacheNotEmpty()) {
        unawaited(_syncRemoteToLocal(pageNumber));
      }

      return Right(entity);
    } on CacheException {
      if (await networkInfo.isConnected) {
        try {
          final remotePage = await remoteDataSource.getPage(pageNumber);
          await localDataSource.cachePage(remotePage);
          return Right(remotePage.toEntity());
        } on ServerException {
          return Left(Failure.fromType(FailureType.serverError));
        }
      } else {
        return Left(Failure.fromType(FailureType.connectionError));
      }
    }
  }

  Future<void> _syncRemoteToLocal(int pageNumber) async {
    try {
      final localPage = await localDataSource.getCachedPage(pageNumber);
      final remotePage = await remoteDataSource.getPage(pageNumber);

      if (localPage.etag != remotePage.etag) {
        await localDataSource.replaceCachedPage(remotePage);
        talker?.debug("Cache updated for page $pageNumber.");
      } else {
        talker?.debug("Cache already up-to-date for page $pageNumber.");
      }
    } catch (e) {
      talker?.debug("Sync error for page $pageNumber: $e");
    }
  }
}
