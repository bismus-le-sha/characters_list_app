import 'package:equatable/equatable.dart';

class CharacterFilterParams extends Equatable {
  final String? name;
  final String? status;
  final String? species;
  final String? type;

  const CharacterFilterParams({
    this.name,
    this.status,
    this.species,
    this.type,
  });

  @override
  List<Object?> get props => [name, status, species, type];
}
