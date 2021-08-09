import 'dart:async';

import '../../model/city/city_sort_info.dart';
import '../../service/city_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'searchcity_event.dart';
part 'searchcity_state.dart';

class SearchCityBloc extends Bloc<SearchCityEvent, SearchCityState> {
  final CityService _cityService;
  SearchCityBloc(this._cityService) : super(SearchResult());

  @override
  Stream<SearchCityState> mapEventToState(
    SearchCityEvent event,
  ) async* {
    print("Event is SearchCityEvent: ${event is SearchCityEvent}");
    if (event is SearchCityEvent) {
      print("Event is SearchCityEvent with key word ${event.keyword}");

      if (event.keyword == null || event.keyword?.length == 0) {
        yield SearchResult(cities: []);
      } else {
        try {
          List<CitySortInfo> response =
              await _cityService.searchCity(event.keyword);
          yield SearchResult(cities: response);
        } catch (err) {
          yield SearchFailed(err.toString());
        }
      }
    }
  }
}
