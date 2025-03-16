import 'package:auto_route/auto_route.dart';
import 'package:characters_list_app/config/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CharactersNavigationPage extends StatelessWidget {
  const CharactersNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(routes: [CharactersRoute()]);
  }
}
