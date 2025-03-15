import 'package:characters_list_app/core/error/exceptions.dart';
import 'package:characters_list_app/features/character/data/models/page_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

abstract class LocalCharacterDataSource {
  Future<void> cachePage(PageModel pageToCache);
  Future<PageModel> getCachedPage(int pageNumber);
  Future<void> replaceCachedPage(PageModel page);
  Future<bool> isCacheNotEmpty();
}

class LocalCharacterDataSourceImpl implements LocalCharacterDataSource {
  final Box<PageModel> pageBox;

  LocalCharacterDataSourceImpl({required this.pageBox});
  @override
  Future<void> cachePage(PageModel pageToCache) async {
    if (pageBox.get(pageToCache.pageNumber) == null) {
      await pageBox.put(pageToCache.pageNumber, pageToCache);
    }
  }

  @override
  Future<PageModel> getCachedPage(int pageNumber) async {
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
  Future<void> replaceCachedPage(PageModel page) async {
    await pageBox.putAt(page.pageNumber, page);
  }
}
