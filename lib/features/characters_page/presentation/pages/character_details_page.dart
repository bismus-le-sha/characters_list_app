import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CharacterDetailsPage extends StatelessWidget {
  final CharacterEntity character;
  final String heroTag;
  const CharacterDetailsPage({
    super.key,
    required this.character,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenSize.height * 0.6,
            elevation: 0,
            snap: true,
            floating: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.zoomBackground],
              background: Hero(
                transitionOnUserGestures: true,
                tag: heroTag,
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: screenSize.height * 0.85,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                color: colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.name,
                              style: TextStyle(fontSize: 22),
                            ),
                            SizedBox(height: 10),
                            Text(character.species),
                          ],
                        ),
                        Text(character.status),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
