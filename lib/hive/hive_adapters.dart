import 'package:characters_list_app/features/fav_characters/data/models/character_model.dart';
import 'package:characters_list_app/features/characters_page/data/models/page_model.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<CharactersPageModel>(),
  AdapterSpec<CharacterModel>(),
])
class HiveAdapters {}
