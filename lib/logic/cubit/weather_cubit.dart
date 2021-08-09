import '../../model/main_request/city.dart';
import '../../model/main_request/forecast.dart';
import '../../model/main_request/iaqi.dart';
import '../../model/main_request/msg.dart';
import '../../service/air_component_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final AirComponentSerivce _airComponentSerivce;
  WeatherCubit(this._airComponentSerivce) : super(WeatherInitial());

  void fetchData(int cityId) async {
    emit(WeatherLoading());
    if (cityId == null) {
      emit(WeatherInitial());
      return;
    }
    try {
      Msg result = await _airComponentSerivce.fetchData(cityId);
      final weatherResult = WeatherResult(
          forecast: result.forecast,
          city: result.city,
          aqi: result.aqi,
          iaqi: result.iaqi);
      emit(weatherResult);
    } catch (ex) {
      emit(WeatherError(ex.toString()));
    }
  }
}
