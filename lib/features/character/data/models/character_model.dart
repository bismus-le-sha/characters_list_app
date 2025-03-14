import 'package:characters_list_app/features/character/domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.episodes,
    required super.image,
  });

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
