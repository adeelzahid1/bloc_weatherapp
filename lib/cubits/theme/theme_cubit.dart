import 'package:bloc/bloc.dart';
import 'package:bloc_weatherapp/constants/constants.dart';


import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  
  ThemeCubit() : super(ThemeState.initial());

  void setTheme(double currentTemp){
      if(currentTemp > kWarmOrNot){
        emit(state.copyWith(appTheme: AppTheme.light));
      }
      else{
        emit(state.copyWith(appTheme: AppTheme.dark));
      }
  }

}
