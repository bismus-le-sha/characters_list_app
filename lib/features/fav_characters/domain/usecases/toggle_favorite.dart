import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/fav_characters_repository.dart';
import 'params/character_params.dart';

class ToggleFavoriteCharacter implements UseCase<void, CharacterParams> {
  final FavCharactersRepository repository;

  ToggleFavoriteCharacter(this.repository);

  @override
  Future<Either<Failure, void>> call(CharacterParams params) async {
    return repository.toggleFavoriteCharacter(params.character);
  }
}
