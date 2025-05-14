import 'package:characters_list_app/config/theme/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState());

  Future<void> changeTheme() async {
    emit(
      state.copyWith(
        themeType:
            state.themeType == ThemeType.light
                ? ThemeType.dark
                : ThemeType.light,
      ),
    );
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) => ThemeState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ThemeState state) => state.toJson();
}
