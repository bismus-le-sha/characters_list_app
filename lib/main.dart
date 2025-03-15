import 'package:characters_list_app/rick_and_morty_characters_app.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const RickAndMortyCharactersApp());
}
