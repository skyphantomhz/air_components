import 'dart:convert';

import 'package:air_components/service/air_component_service.dart';
import 'package:air_components/service/city_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton<Client>(() => Client());
  getIt.registerLazySingleton<JsonDecoder>(() => JsonDecoder());
  getIt.registerLazySingleton<CityService>(() => CityService());
  getIt.registerLazySingleton<AirComponentSerivce>(() => AirComponentSerivce());
}