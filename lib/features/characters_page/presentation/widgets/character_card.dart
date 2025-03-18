import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:characters_list_app/features/fav_characters/domain/entities/character_entity.dart';
import 'package:characters_list_app/injection_container/injection_container_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                child:
                    BlocSelector<FavCharactersBloc, FavCharactersState, bool>(
                      selector: (state) {
                        return state.favCharactersList.any(
                          (favCharacter) => favCharacter == character,
                        );
                      },
                      builder: (context, isFavorite) {
                        return Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            isSelected: isFavorite,
                            onPressed:
                                () => context.read<FavCharactersBloc>().add(
                                  FavCharacterToggle(character),
                                ),
                            icon: Icon(Icons.bookmark_border),
                            selectedIcon: Icon(Icons.bookmark_added),
                          ),
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
