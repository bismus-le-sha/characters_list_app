import 'package:http/http.dart' as http;
import 'injection_container_export.dart';

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

  //! Config
  sl.registerSingleton<AppRouter>(AppRouter());

  //!Debug Talker
  sl.registerSingleton<Talker>(TalkerFlutter.init());
}
