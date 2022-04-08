part of 'theme_cubit.dart';

class ThemeState extends Equatable {
   final AppTheme appTheme;
  const ThemeState({this.appTheme = AppTheme.light});

factory ThemeState.initial(){
  return ThemeState();
}

  @override
  List<Object> get props => [appTheme];

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }

  @override
  bool get stringify => true;
}

enum AppTheme{
  dark, light
}
