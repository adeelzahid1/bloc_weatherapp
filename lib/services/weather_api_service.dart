import 'dart:convert';
import 'package:bloc_weatherapp/constants/constants.dart';
import 'package:bloc_weatherapp/exception/weather_exception.dart';
import 'package:bloc_weatherapp/models/weather.dart';
import 'package:bloc_weatherapp/services/http_error_handler.dart';
import 'package:http/http.dart' as http;
class WeatherApiServices{

  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });

  Future<int> getWoeid(String city) async{
    final Uri uri = Uri(
      host: kHost,
      scheme: 'https',
      path: '/api/location/search/',
      queryParameters: {'query': city, } ,
    );

    try{
      final http.Response response = await http.get(uri);
      
      if(response.statusCode != 200){
        throw Exception(httpErrorHandler(response));  
      }
      
      final responseBody = json.decode(response.body);

      if(responseBody.isEmpty){
        throw WeatherException('Cannot get the woeid of $city');
      }

      if(responseBody.length > 1){
        throw WeatherException('There are multiple cities for $city \n Please specify furthur !');
      }

         return responseBody[0]['woeid'];
    }
    catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(int woeid) async{
    final Uri uri = Uri(
      scheme: 'https',
      host: kHost,
      path: '/api/location/$woeid',
    );

    try {
        final http.Response response = await http.get(uri);
        if(response.statusCode != 200){
          throw Exception(httpErrorHandler(response));
        }      
        final weatherJson = json.decode(response.body);
        final Weather weather = Weather.fromJson(weatherJson);

        print(weather);
        return weather;

    } catch (e) {
      rethrow;
    }
  }


}
