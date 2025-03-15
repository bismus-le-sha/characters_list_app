import 'package:equatable/equatable.dart';

class CharactersParams extends Equatable {
  final int page;

  const CharactersParams({required this.page});

  @override
  List<Object?> get props => [page];
}
