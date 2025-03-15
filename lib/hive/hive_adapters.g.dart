// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class PageModelAdapter extends TypeAdapter<PageModel> {
  @override
  final int typeId = 0;

  @override
  PageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PageModel(
      pageNumber: (fields[5] as num).toInt(),
      count: (fields[0] as num).toInt(),
      pages: (fields[1] as num).toInt(),
      next: fields[2] as String?,
      prev: fields[3] as String?,
      characters: (fields[4] as List).cast<CharacterModel>(),
      etag: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PageModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.pages)
      ..writeByte(2)
      ..write(obj.next)
      ..writeByte(3)
      ..write(obj.prev)
      ..writeByte(4)
      ..write(obj.characters)
      ..writeByte(5)
      ..write(obj.pageNumber)
      ..writeByte(8)
      ..write(obj.etag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageModelAdapter &&
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
      name: fields[0] as String,
      status: fields[1] as String,
      species: fields[2] as String,
      type: fields[3] as String,
      episodes: (fields[4] as List).cast<String>(),
      image: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.species)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.episodes)
      ..writeByte(5)
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
