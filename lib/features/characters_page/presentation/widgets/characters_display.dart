import 'package:characters_list_app/features/characters_page/domain/entities/character_entity.dart';
import 'package:characters_list_app/features/characters_page/presentation/bloc/character_bloc.dart';
import 'package:characters_list_app/features/characters_page/presentation/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersDisplay extends StatefulWidget {
  const CharactersDisplay({
    super.key,
    required this.characters,
    required this.hasReachedMax,
  });
  final List<CharacterEntity> characters;
  final bool hasReachedMax;

  @override
  State<CharactersDisplay> createState() => _CharactersDisplayState();
}

class _CharactersDisplayState extends State<CharactersDisplay> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<CharactersPageBloc>().add(CharactersPageLoad());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: widget.characters.length + (widget.hasReachedMax ? 0 : 1),
        itemBuilder: (context, index) {
          if (index < widget.characters.length) {
            return CharacterCard(character: widget.characters[index]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
