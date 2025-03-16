import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../features/characters_page/domain/entities/character_entity.dart';
import '../../features/characters_page/presentation/pages/characters_navigation_page.dart';
import '../../features/characters_page/presentation/pages/characters_page.dart';
import '../../features/characters_page/presentation/pages/character_details_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: CharactersNavigationRoute.page,
      initial: true,
      children: [AutoRoute(page: CharactersRoute.page, initial: true)],
    ),
    AutoRoute(page: CharacterDetailsRoute.page),
  ];
}
