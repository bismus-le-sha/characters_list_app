import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:characters_list_app/config/router/router.dart';
import 'package:characters_list_app/features/character/domain/entities/character_entity.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.2;
    return GestureDetector(
      onTap: () {
        context.pushRoute(CharacterDetailsRoute(character: character));
      },
      child: AnimatedContainer(
        clipBehavior: Clip.hardEdge,
        duration: Duration(microseconds: 200),
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
          tag: character.name,
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
                  child: Icon(Icons.bookmark_border),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
