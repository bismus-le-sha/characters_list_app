import 'package:characters_list_app/features/character/data/models/character_model.dart';
import 'package:characters_list_app/features/character/data/models/page_model.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<PageModel>(), AdapterSpec<CharacterModel>()])
class HiveAdapters {}
