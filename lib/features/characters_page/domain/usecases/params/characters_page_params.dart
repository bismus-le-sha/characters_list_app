import 'package:equatable/equatable.dart';

class CharactersPageParams extends Equatable {
  final int pageNumber;

  const CharactersPageParams({required this.pageNumber});

  @override
  List<Object?> get props => [pageNumber];
}
