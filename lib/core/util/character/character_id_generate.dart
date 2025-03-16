class CharacterIdGenerate {
  static int generateCharacterId(String name, String species, String type) {
    return '$name|$species|$type'.hashCode;
  }
}
