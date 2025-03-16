import 'package:http/http.dart' as http;

import 'injection_container_export.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - CharactersPage

  // Bloc
  sl.registerFactory(() => CharactersPageBloc(getCharactersPage: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCharactersPage(sl()));

  // Repository
  sl.registerLazySingleton<CharactersPageRepository>(
    () => CharactersPageRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
      talker: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RemoteCharactersPageDataSource>(
    () => RemoteCharactersDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LocalCharactersPageDataSource>(
    () => LocalCharactersPageDataSourceImpl(pageBox: sl()),
  );

  //! Features - Character

  //Bloc
  sl.registerFactory(
    () => FavCharactersBloc(
      getAllCharacters: sl(),
      toggleFavoriteCharacter: sl(),
      updateCharacter: sl(),
    ),
  );

  //Use cases
  sl.registerLazySingleton(() => GetAllCharacters(sl()));
  sl.registerLazySingleton(() => UpdateCharacter(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteCharacter(sl()));

  //Repository
  sl.registerLazySingleton<FavCharactersRepository>(
    () => FavCharactersRepositoryImpl(datasource: sl()),
  );

  //Data sources
  sl.registerLazySingleton<FavCharactersDatasource>(
    () => FavCharactersDatasourceImpl(favCharactersBox: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());

  //Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CharactersPageModelAdapter());
  Hive.registerAdapter(CharacterModelAdapter());

  final pageBox = await Hive.openBox<CharactersPageModel>(PAGE_BOX);
  final favCharactersBox = await Hive.openBox<CharacterModel>(
    FAV_CHARACTERS_BOX,
  );
  sl.registerLazySingleton(() => pageBox);
  sl.registerLazySingleton(() => favCharactersBox);

  //! Config
  sl.registerSingleton<AppRouter>(AppRouter());

  //!Debug Talker
  sl.registerSingleton<Talker>(TalkerFlutter.init());
}
