import 'dart:convert';

import '../../model/city/city_sort_info.dart';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> with HydratedMixin {
  CityCubit() : super(CityState());

  void addCity(CitySortInfo city) {
    if (state.cities == null) {
      emit(CityState(citySelected: city, cities: [city]));
    } else if (!state.cities.contains(city)) {
      final newList = state.cities..add(city);
      emit(state.copyWith(cities: newList));
    }
  }

  void selectCity(CitySortInfo city) {
    emit(state.copyWith(citySelected: city));
  }

  @override
  CityState fromJson(Map<String, dynamic> json) {
    return CityState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(CityState state) {
    return state.toMap();
  }
}
