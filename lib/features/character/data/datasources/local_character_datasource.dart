import 'package:characters_list_app/features/character/data/models/page_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalCharacterDataSource {
  Future<void> cachePage(PageModel charactersToCache, int page);
  Future<PageModel> getLastCharacters(int page);
}

class LocalCharacterDataSourceImpl implements LocalCharacterDataSource {
  final SharedPreferences sharedPreferences;

  LocalCharacterDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cachePage(PageModel charactersToCache, int page) {
    return Future.value();
  }

  @override
  Future<PageModel> getLastCharacters(int page) {
    // TODO: implement getLastCharacters
    throw UnimplementedError();
  }
}
