part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherResult extends WeatherState {
  final Forecast forecast;
  final City city;
  final int aqi;
  final List<Iaqi> iaqi;

  WeatherResult({this.forecast, this.city, this.aqi, this.iaqi});
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}
