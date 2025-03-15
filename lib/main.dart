import 'package:bloc/bloc.dart';
import 'package:characters_list_app/rick_and_morty_characters_app.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:flutter/material.dart';
import 'injection_container/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  final talker = di.sl<Talker>();

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  FlutterError.onError =
      (details) => talker.handle(details.exception, details.stack);

  runApp(const RickAndMortyCharactersApp());
}
