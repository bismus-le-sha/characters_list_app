import '../constants/messages.dart';

enum FailureType {
  serverError,
  connectionError,
  cacheUpdateError,
  characterAlreadyExistError,
  characterNotExistError,
  favoriteCharacterOperationError,
}

class Failure {
  final FailureType type;
  final String message;

  const Failure(this.type, this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.type == type;
  }

  @override
  int get hashCode => type.hashCode;

  static const Map<FailureType, String> _defaultMessages = {
    FailureType.serverError: SERVER_FAILURE_MESSAGE,
    FailureType.connectionError: CONNECTION_FAILURE_MESSAGE,
    FailureType.cacheUpdateError: CACHE_UPDATE_FAILURE_MESSAGE,
    FailureType.characterAlreadyExistError: CHARACTER_ALREADY_EXIST_MESSAGE,
    FailureType.characterNotExistError: CHARACTER_DONT_EXIST_MESSAGE,
    FailureType.favoriteCharacterOperationError:
        FAV_CHARACTER_OPERATION_MESSAGE,
  };

  factory Failure.fromType(FailureType type, {String? customMessage}) {
    return Failure(type, customMessage ?? _defaultMessages[type]!);
  }
}
