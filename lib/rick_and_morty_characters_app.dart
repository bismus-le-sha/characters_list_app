import 'package:characters_list_app/config/router/router.dart';
import 'package:characters_list_app/config/theme/cubit/theme_cubit.dart';
import 'package:characters_list_app/features/characters_page/presentation/bloc/character_bloc.dart';
import 'package:characters_list_app/features/fav_characters/presentation/bloc/fav_characters_bloc.dart';
import 'package:characters_list_app/features/fav_characters/presentation/cubit/sort_characters_cubit.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container/injection_container.dart' as di;

class RickAndMortyCharactersApp extends StatelessWidget {
  const RickAndMortyCharactersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CharactersPageBloc>()),
        BlocProvider(create: (_) => di.sl<FavCharactersBloc>()),
        BlocProvider(create: (_) => di.sl<FavCharactersSortingCubit>()),
        BlocProvider(create: (_) => di.sl<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: di.sl<AppRouter>().config(
              navigatorObservers: () => [TalkerRouteObserver(di.sl<Talker>())],
            ),
            theme: state.themeData,
          );
        },
      ),
    );
  }
}
