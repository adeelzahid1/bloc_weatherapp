part of 'temp_settings_cubit.dart';

class TempSettingsState extends Equatable {
  final TempUnit tempUnit;
  const TempSettingsState({this.tempUnit = TempUnit.celsius});

  factory TempSettingsState.initial(){
    return const TempSettingsState();
  }

  @override
  List<Object> get props => [tempUnit];

  

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }

    @override
  bool get stringify => true;
}


enum TempUnit {
  celsius,
  fahrenheit,
}