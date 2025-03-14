import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final String name;
  final String status;
  final String species;
  final String type;
  final List<String> episodes;
  final String image;

  const CharacterEntity({
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.episodes,
    required this.image,
  });

  @override
  List<Object?> get props => [name, status, species, type, episodes, image];
}
