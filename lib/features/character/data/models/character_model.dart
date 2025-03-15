import 'package:characters_list_app/features/character/domain/entities/character_entity.dart';
import 'package:hive_ce_flutter/adapters.dart';

class CharacterModel extends HiveObject {
  final String name;
  final String status;
  final String species;
  final String type;
  final List<String> episodes;
  final String image;

  CharacterModel({
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.episodes,
    required this.image,
  });

  CharacterEntity toEntity() {
    return CharacterEntity(
      name: name,
      status: status,
      species: species,
      type: type,
      episodes: episodes,
      image: image,
    );
  }

  static CharacterModel fromEntity(CharacterEntity entity) {
    return CharacterModel(
      name: entity.name,
      status: entity.status,
      species: entity.species,
      type: entity.type,
      episodes: entity.episodes,
      image: entity.image,
    );
  }

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      episodes: List<String>.from(json['episode']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "status": status,
      "species": species,
      "type": type,
      "episode": episodes,
      "image": image,
    };
  }
}
