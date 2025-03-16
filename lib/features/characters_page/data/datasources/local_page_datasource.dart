import 'package:characters_list_app/core/error/exceptions.dart';
import 'package:characters_list_app/features/characters_page/data/models/page_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

abstract class LocalCharactersPageDataSource {
  Future<void> cachePage(CharactersPageModel pageToCache);
  Future<CharactersPageModel> getCachedPage(int pageNumber);
  Future<void> replaceCachedPage(CharactersPageModel page);
  Future<bool> isCacheNotEmpty();
}

class LocalCharactersPageDataSourceImpl
    implements LocalCharactersPageDataSource {
  final Box<CharactersPageModel> pageBox;

  LocalCharactersPageDataSourceImpl({required this.pageBox});
  @override
  Future<void> cachePage(CharactersPageModel pageToCache) async {
    if (pageBox.get(pageToCache.pageNumber) == null) {
      await pageBox.put(pageToCache.pageNumber, pageToCache);
    }
  }

  @override
  Future<CharactersPageModel> getCachedPage(int pageNumber) async {
    final cachePage = pageBox.get(pageNumber);
    if (cachePage != null) {
      return Future.value(cachePage);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> isCacheNotEmpty() {
    return Future.value(pageBox.isNotEmpty);
  }

  @override
  Future<void> replaceCachedPage(CharactersPageModel page) async {
    await pageBox.putAt(page.pageNumber, page);
  }
}
