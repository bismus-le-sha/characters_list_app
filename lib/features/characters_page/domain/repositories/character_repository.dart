import 'package:characters_list_app/features/characters_page/domain/entities/page_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class CharactersPageRepository {
  Future<Either<Failure, CharactersPageEntity>> getPage(int pageNumber);
}
