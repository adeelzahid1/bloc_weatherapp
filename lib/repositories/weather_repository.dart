import 'package:bloc_weatherapp/exception/weather_exception.dart';
import 'package:bloc_weatherapp/models/custom_error.dart';
import 'package:bloc_weatherapp/models/weather.dart';
import 'package:bloc_weatherapp/services/weather_api_service.dart';


class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  
  WeatherRepository({
    required this.weatherApiServices,
  });
  
  Future<Weather> fetchWeather(String city) async{
    print(city);
    try {
      final int woeid = await weatherApiServices.getWoeid(city);
      print(woeid);

      final Weather weather = await weatherApiServices.getWeather(woeid);
      print(weather);
      return weather;

    } on WeatherException catch 
     (e) {
      throw CustomError(errMsg: e.message);
    }
    catch (e){ throw CustomError(errMsg: e.toString());}
  }
  
}
