class Urls {
  static const String characterUrl =
      'https://rickandmortyapi.com/api/character';
  static String getCharactersPage(int page) => '$characterUrl?page=$page';
}
