import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:characters_list_app/core/widgets/characters/models/character_card_data_model.dart';
import 'package:characters_list_app/injection_container/injection_container_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterCardGesture extends StatelessWidget {
  final CharacterCardData characterCardData;
  const CharacterCardGesture({super.key, required this.characterCardData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(
          CharacterDetailsRoute(
            character: characterCardData.character,
            heroTag: characterCardData.heroTag,
          ),
        );
      },
      child: CharacterCard(characterCardData: characterCardData),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final CharacterCardData characterCardData;
  const CharacterCard({super.key, required this.characterCardData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      duration: Duration(microseconds: 500),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(100),
            offset: Offset(5, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Hero(
        transitionOnUserGestures: true,
        tag: characterCardData.heroTag,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: characterCardData.character.image,
              placeholder:
                  (context, url) =>
                      Center(child: const CircularProgressIndicator()),
              errorWidget:
                  (context, url, error) =>
                      Center(child: const Icon(Icons.error)),
            ),
            PositionedDirectional(
              start: characterCardData.height * 0.85,
              top: characterCardData.height * 0.05,
              child: FavIconHolder(
                colorScheme: colorScheme,
                isFavorite: characterCardData.isFavorite,
                onPressed:
                    () => context.read<FavCharactersBloc>().add(
                      FavCharacterToggle(characterCardData.character),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavIconHolder extends StatelessWidget {
  final ColorScheme colorScheme;
  final bool isFavorite;
  final VoidCallback onPressed;
  const FavIconHolder({
    super.key,
    required this.isFavorite,
    required this.onPressed,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorScheme.surface,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        isSelected: isFavorite,
        onPressed: onPressed,
        icon: FavIcon(isFavorite: isFavorite, colorScheme: colorScheme),
      ),
    );
  }
}

class FavIcon extends StatelessWidget {
  final ColorScheme colorScheme;
  final bool isFavorite;
  const FavIcon({
    super.key,
    required this.isFavorite,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final spinAnimation = Tween(begin: pi, end: 0.0).animate(animation);
        return AnimatedBuilder(
          animation: spinAnimation,
          child: child,
          builder: (context, child) {
            final isUnder = child!.key != ValueKey(isFavorite);
            final value =
                isUnder
                    ? min(spinAnimation.value, pi / 2)
                    : spinAnimation.value;
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
        color: isFavorite ? colorScheme.secondary : Colors.grey,
      ),
    );
  }
}
