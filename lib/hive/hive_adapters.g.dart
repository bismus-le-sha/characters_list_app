// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class CharactersPageModelAdapter extends TypeAdapter<CharactersPageModel> {
  @override
  final int typeId = 0;

  @override
  CharactersPageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharactersPageModel(
      pageNumber: (fields[0] as num).toInt(),
      count: (fields[1] as num).toInt(),
      pages: (fields[2] as num).toInt(),
      next: fields[3] as String?,
      prev: fields[4] as String?,
      characters: (fields[5] as List).cast<CharacterModel>(),
      etag: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CharactersPageModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.pageNumber)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.pages)
      ..writeByte(3)
      ..write(obj.next)
      ..writeByte(4)
      ..write(obj.prev)
      ..writeByte(5)
      ..write(obj.characters)
      ..writeByte(6)
      ..write(obj.etag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharactersPageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CharacterModelAdapter extends TypeAdapter<CharacterModel> {
  @override
  final int typeId = 1;

  @override
  CharacterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterModel(
      id: (fields[0] as num).toInt(),
      name: fields[1] as String,
      status: fields[2] as String,
      species: fields[3] as String,
      type: fields[4] as String,
      episodes: (fields[5] as List).cast<String>(),
      image: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.species)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.episodes)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
