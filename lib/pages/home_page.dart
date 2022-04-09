import 'package:bloc_weatherapp/pages/search_page.dart';
import 'package:bloc_weatherapp/pages/settings_page.dart';
import 'package:bloc_weatherapp/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
             onPressed: () async =>{
               _city = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage())),
                print(_city),
                if(_city!=null){
                  context.read<WeatherBloc>().add(FetchWeatherEvent(city: _city!)),
                }
             },
              icon: const Icon(Icons.search),
             ),

             IconButton(
               onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));},
                icon: const Icon(Icons.settings)
                ),
        ],
      ),
      body: _showWeather(),
    );
  }

 String showTemperature(double temperature){
   final tempUnit = context.watch<TempSettingsBloc>().state.tempUnit;
   if(tempUnit == TempUnit.fahrenheit){
     return ((temperature * 9/5 ) +32).toStringAsFixed(2) + ' ℉';
   }
    return temperature.toStringAsFixed(2) + '℃';
  }

  Widget showIcon(String abbr) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'https://$kHost/static/img/weather/png/64/$abbr.png',
      width: 64,
      height: 64,
    );
  }
  

  Widget _showWeather(){
    return BlocConsumer<WeatherBloc, WeatherState>(
       listener: (context, state) {
         if(state.status == WeatherStatus.error){
           errorDialog(context, state.error.errMsg);
         }
       } ,
      builder: (context, state){
        if(state.status == WeatherStatus.initial){
          return const Center(
            child: Text('Select a City', style: TextStyle(fontSize: 20.0),),
          );
        }
        if(state.status == WeatherStatus.loading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if(state.status == WeatherStatus.error){
          return const Center(
            child: Text('Selct a City'),
          );
        } 

      return ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 6),
          Text(state.weather.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 40.0, letterSpacing: 1.4, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10.0),
          Text(TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context), textAlign: TextAlign.center, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
           const SizedBox(height: 60.0),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(showTemperature(state.weather.theTemp), textAlign: TextAlign.center, style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
               const SizedBox(width: 20.0),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [  
               Text(showTemperature(state.weather.maxTemp), style: const TextStyle(fontSize: 16.0),),
              const  SizedBox(height:10.0),
               Text(showTemperature(state.weather.minTemp), style: const TextStyle(fontSize: 16.0)),
             ],
           ),
             ],
           ),

            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               const  Spacer(),
                showIcon(state.weather.weatherStateAbbr),
               const  SizedBox(width: 30.0),
                Text(
                  state.weather.weatherStateName,
                  style: const TextStyle(fontSize: 32.0),
                ),
                const Spacer(),
              ],
            ),


          
        ],
      );
      }
       );
  }

}
