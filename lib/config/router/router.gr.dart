// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [CharacterDetailsPage]
class CharacterDetailsRoute extends PageRouteInfo<CharacterDetailsRouteArgs> {
  CharacterDetailsRoute({
    Key? key,
    required CharacterEntity character,
    List<PageRouteInfo>? children,
  }) : super(
         CharacterDetailsRoute.name,
         args: CharacterDetailsRouteArgs(key: key, character: character),
         initialChildren: children,
       );

  static const String name = 'CharacterDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CharacterDetailsRouteArgs>();
      return CharacterDetailsPage(key: args.key, character: args.character);
    },
  );
}

class CharacterDetailsRouteArgs {
  const CharacterDetailsRouteArgs({this.key, required this.character});

  final Key? key;

  final CharacterEntity character;

  @override
  String toString() {
    return 'CharacterDetailsRouteArgs{key: $key, character: $character}';
  }
}

/// generated route for
/// [CharactersNavigationPage]
class CharactersNavigationRoute extends PageRouteInfo<void> {
  const CharactersNavigationRoute({List<PageRouteInfo>? children})
    : super(CharactersNavigationRoute.name, initialChildren: children);

  static const String name = 'CharactersNavigationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CharactersNavigationPage();
    },
  );
}

/// generated route for
/// [CharactersPage]
class CharactersRoute extends PageRouteInfo<void> {
  const CharactersRoute({List<PageRouteInfo>? children})
    : super(CharactersRoute.name, initialChildren: children);

  static const String name = 'CharactersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CharactersPage();
    },
  );
}

/// generated route for
/// [FavCharactersPage]
class FavCharactersRoute extends PageRouteInfo<void> {
  const FavCharactersRoute({List<PageRouteInfo>? children})
    : super(FavCharactersRoute.name, initialChildren: children);

  static const String name = 'FavCharactersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavCharactersPage();
    },
  );
}
