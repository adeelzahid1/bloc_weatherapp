import 'blocs/blocs.dart';
import 'package:bloc_weatherapp/pages/home_page.dart';
import 'package:bloc_weatherapp/repositories/weather_repository.dart';
import 'package:bloc_weatherapp/services/weather_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(httpClient: http.Client()),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(
                weatherRepository: context.read<WeatherRepository>()),
          ),
          BlocProvider<TempSettingsBloc>(
              create: (context) => TempSettingsBloc()),
          BlocProvider<ThemeBloc>(create: (context) => ThemeBloc(weatherBloc: context.read<WeatherBloc>())),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Weather App',
              debugShowCheckedModeBanner: false,
              theme: state.appTheme == AppTheme.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
              home: const HomePage(),
            );
          },
        ),
      ),
    );
  }
}
