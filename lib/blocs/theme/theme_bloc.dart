import 'package:bloc/bloc.dart';
import 'package:bloc_weatherapp/constants/constants.dart';
import 'package:equatable/equatable.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {


  ThemeBloc() : super(ThemeState.initial()) {
    on<ChangeThemeEvent>((event, emit) {
     emit(state.copyWith(appTheme: event.appTheme));
    });
  }

  void setTheme(double currentTemp){
      if(currentTemp > kWarmOrNot){
          add(const ChangeThemeEvent(appTheme: AppTheme.light));
      }
      else {
        add(const ChangeThemeEvent(appTheme: AppTheme.dark));
      }
  }
}

