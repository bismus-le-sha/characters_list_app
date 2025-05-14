part of 'theme_cubit.dart';

enum ThemeType { light, dark }

extension ThemeTypeExtension on ThemeType {
  ThemeData get theme {
    switch (this) {
      case ThemeType.light:
        return lightMode;
      case ThemeType.dark:
        return darkMode;
    }
  }
}

final class ThemeState extends Equatable {
  const ThemeState({this.themeType = ThemeType.light});
  final ThemeType themeType;
  ThemeData get themeData => themeType.theme;

  ThemeState copyWith({ThemeType? themeType}) {
    return ThemeState(themeType: themeType ?? this.themeType);
  }

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      themeType: json['themeType'] == 'dark' ? ThemeType.dark : ThemeType.light,
    );
  }

  Map<String, dynamic> toJson() {
    return {'themeType': themeType.name};
  }

  @override
  List<Object> get props => [themeType];
}
