import 'package:characters_list_app/features/character/domain/entities/page_entity.dart';
import 'package:characters_list_app/features/character/data/models/character_model.dart';

class PageModel extends PageEntity {
  const PageModel({
    required super.count,
    required super.pages,
    super.next,
    super.prev,
    required super.characters,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      count: json['info']['count'] as int,
      pages: json['info']['pages'] as int,
      next: json['info']['next'] as String?,
      prev: json['info']['prev'] as String?,
      characters:
          (json['results'] as List)
              .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': {'count': count, 'pages': pages, 'next': next, 'prev': prev},
      'results': characters.map((e) => (e as CharacterModel).toJson()).toList(),
    };
  }
}
