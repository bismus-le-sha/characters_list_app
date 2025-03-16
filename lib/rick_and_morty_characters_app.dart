import 'package:characters_list_app/config/router/router.dart';
import 'package:characters_list_app/features/character/presentation/bloc/character_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container/injection_container.dart' as di;

class RickAndMortyCharactersApp extends StatelessWidget {
  const RickAndMortyCharactersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<CharacterBloc>(),
      child: MaterialApp.router(
        routerConfig: di.sl<AppRouter>().config(
          navigatorObservers: () => [TalkerRouteObserver(di.sl<Talker>())],
        ),
      ),
    );
  }
}
