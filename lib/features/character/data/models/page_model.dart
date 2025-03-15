import 'package:characters_list_app/features/character/domain/entities/page_entity.dart';
import 'package:characters_list_app/features/character/data/models/character_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class PageModel extends HiveObject {
  final int pageNumber;
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  final List<CharacterModel> characters;
  final String? etag;

  PageModel({
    required this.pageNumber,
    required this.count,
    required this.pages,
    this.next,
    this.prev,
    required this.characters,
    required this.etag,
  });

  PageEntity toEntity() {
    return PageEntity(
      count: count,
      pages: pages,
      next: next,
      prev: prev,
      characters: characters.map((c) => c.toEntity()).toList(),
    );
  }

  static PageModel fromEntity(PageEntity entity) {
    return PageModel(
      pageNumber: -1,
      count: entity.count,
      pages: entity.pages,
      next: entity.next,
      prev: entity.prev,
      characters:
          entity.characters.map((c) => CharacterModel.fromEntity(c)).toList(),
      etag: '',
    );
  }

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      pageNumber: -1,
      count: json['info']['count'] as int,
      pages: json['info']['pages'] as int,
      next: json['info']['next'] as String?,
      prev: json['info']['prev'] as String?,
      characters:
          (json['results'] as List)
              .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      etag: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': {'count': count, 'pages': pages, 'next': next, 'prev': prev},
      'results': characters.map((e) => e.toJson()).toList(),
    };
  }

  PageModel copyWith({int? pageNumber, String? etag}) {
    return PageModel(
      pageNumber: pageNumber ?? this.pageNumber,
      count: count,
      pages: pages,
      next: next,
      prev: prev,
      characters: characters,
      etag: etag ?? this.etag,
    );
  }
}
