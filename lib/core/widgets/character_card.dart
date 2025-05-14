import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';
import 'package:characters_list_app/injection_container/injection_container_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  final String pageViewTag;
  final bool isFavorite;
  const CharacterCard({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.pageViewTag,
  });

  @override
  Widget build(BuildContext context) {
    final heroTag = pageViewTag + character.name;
    final double height = MediaQuery.of(context).size.height * 0.2;
    return GestureDetector(
      onTap: () {
        context.pushRoute(
          CharacterDetailsRoute(character: character, heroTag: heroTag),
        );
      },
      child: AnimatedContainer(
        clipBehavior: Clip.hardEdge,
        duration: Duration(microseconds: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(45),
              offset: Offset(5, 5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Hero(
          transitionOnUserGestures: true,
          tag: heroTag,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: character.image,
                placeholder:
                    (context, url) =>
                        Center(child: const CircularProgressIndicator()),
                errorWidget:
                    (context, url, error) =>
                        Center(child: const Icon(Icons.error)),
              ),
              PositionedDirectional(
                start: height * 0.9,
                top: height * 0.1,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    isSelected: isFavorite,
                    onPressed: () {
                      context.read<FavCharactersBloc>().add(
                        FavCharacterToggle(character),
                      );
                    },
                    icon: animatedStarIcon(
                      isFavorite: isFavorite,
                      key: ValueKey(isFavorite),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget animatedStarIcon({required bool isFavorite, required Key key}) {
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (Widget child, Animation<double> animation) {
      final spinAnimation = Tween(begin: pi, end: 0.0).animate(animation);

      return AnimatedBuilder(
        animation: spinAnimation,
        child: child,
        builder: (context, child) {
          final isUnder = child!.key != ValueKey(isFavorite);
          final value =
              isUnder ? min(spinAnimation.value, pi / 2) : spinAnimation.value;

          return Transform(
            transform: Matrix4.rotationY(value),
            alignment: Alignment.center,
            child: child,
          );
        },
      );
    },
    child: Icon(
      isFavorite ? Icons.star : Icons.star_border,
      key: ValueKey(isFavorite),
      color: isFavorite ? Colors.deepPurple : Colors.grey,
    ),
  );
}
