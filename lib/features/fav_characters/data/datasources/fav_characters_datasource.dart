import 'package:characters_list_app/core/error/exceptions.dart';
import 'package:characters_list_app/core/util/character/character_id_generate.dart';
import 'package:characters_list_app/features/fav_characters/data/models/character_model.dart';
import 'package:hive_ce/hive.dart';

import '../../domain/entities/character_entity.dart';

abstract class FavCharactersDatasource {
  Future<List<CharacterModel>> getAllCharacters(
    String? name,
    String? status,
    String? species,
    String? type,
  );
  Future<void> addCharacter(CharacterEntity character);
  Future<void> updateCharacter(CharacterEntity character);
  Future<void> deleteCharacter(CharacterEntity character);
  Future<bool> isFavCharacter(CharacterEntity character);
}

class FavCharactersDatasourceImpl implements FavCharactersDatasource {
  final Box<CharacterModel> favCharactersBox;

  FavCharactersDatasourceImpl({required this.favCharactersBox});

  @override
  Future<void> addCharacter(CharacterEntity character) async {
    final id = CharacterIdGenerate.generateCharacterId(
      character.name,
      character.species,
      character.type,
    );

    if (favCharactersBox.containsKey(id)) {
      throw CharacterAlreadyExistException();
    }
    final CharacterModel favCharacter = CharacterModel(
      id: id,
      name: character.name,
      status: character.status,
      species: character.species,
      type: character.type,
      episodes: character.episodes,
      image: character.image,
    );
    await favCharactersBox.put(favCharacter.id, favCharacter);
  }

  @override
  Future<void> deleteCharacter(CharacterEntity character) async {
    final id = CharacterIdGenerate.generateCharacterId(
      character.name,
      character.species,
      character.type,
    );
    if (!favCharactersBox.containsKey(id)) {
      throw CharacterNotExistException();
    }
    await favCharactersBox.delete(id);
  }

  @override
  Future<List<CharacterModel>> getAllCharacters(
    String? name,
    String? status,
    String? species,
    String? type,
  ) async {
    if (favCharactersBox.isEmpty) {
      return [];
    }
    return await Future.value(favCharactersBox.values.toList());
  }

  @override
  Future<void> updateCharacter(CharacterEntity character) async {
    final id = CharacterIdGenerate.generateCharacterId(
      character.name,
      character.species,
      character.type,
    );
    if (!favCharactersBox.containsKey(id)) {
      throw CharacterNotExistException();
    }
    final CharacterModel favCharacter = CharacterModel(
      id: id,
      name: character.name,
      status: character.status,
      species: character.species,
      type: character.type,
      episodes: character.episodes,
      image: character.image,
    );
    await favCharactersBox.putAt(favCharacter.id, favCharacter);
  }

  @override
  Future<bool> isFavCharacter(CharacterEntity character) async {
    final id = CharacterIdGenerate.generateCharacterId(
      character.name,
      character.species,
      character.type,
    );
    return favCharactersBox.containsKey(id);
  }
}
