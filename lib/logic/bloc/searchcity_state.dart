part of 'searchcity_bloc.dart';

@immutable
abstract class SearchCityState {}

class SearchFailed extends SearchCityState {
  final String message;
  SearchFailed(this.message);
}

class SearchResult extends SearchCityState {
  final List<CitySortInfo> cities;

  SearchResult({this.cities});
}
