import 'package:characters_list_app/features/character/domain/entities/page_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class CharacterRepository {
  Future<Either<Failure, PageEntity>> getPage(int page);
}
