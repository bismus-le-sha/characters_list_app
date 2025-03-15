import 'package:characters_list_app/core/constants/hive_boxes.dart';
import 'package:characters_list_app/features/character/data/models/page_model.dart';
import 'package:characters_list_app/hive/hive_adapters.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'core/util/network/network_info.dart';
import 'features/character/data/datasources/local_character_datasource.dart';
import 'features/character/data/datasources/remote_character_datasource.dart';
import 'features/character/data/repositories/character_repository_impl.dart';
import 'features/character/domain/repositories/character_repository.dart';
import 'features/character/domain/usecases/get_characters_page.dart';
import 'features/character/presentation/bloc/character_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Character

  // Bloc
  sl.registerFactory(() => CharacterBloc(getCharactersPage: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCharactersPage(sl()));

  // Repository
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RemoteCharacterDataSource>(
    () => RemoteCharacterDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LocalCharacterDataSource>(
    () => LocalCharacterDataSourceImpl(pageBox: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());

  //Hive
  await Hive.initFlutter();
  Hive.registerAdapter(PageModelAdapter());
  Hive.registerAdapter(CharacterModelAdapter());

  final pageBox = await Hive.openBox<PageModel>(PAGE_BOX);
  sl.registerLazySingleton(() => pageBox);
}
