import 'package:auto_route/auto_route.dart';
import 'package:characters_list_app/config/router/router.dart';
import 'package:characters_list_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CharactersNavigationPage extends StatelessWidget {
  const CharactersNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: [CharactersRoute(), FavCharactersRoute()],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: CustomNavBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
          ),
        );
      },
    );
  }
}
