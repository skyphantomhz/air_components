part of 'city_cubit.dart';

class CityState {
  final CitySortInfo citySelected;
  final List<CitySortInfo> cities;

  CityState({this.citySelected, this.cities});

  CityState copyWith({
    CitySortInfo citySelected,
    List<CitySortInfo> cities,
  }) {
    return CityState(
      citySelected: citySelected ?? this.citySelected,
      cities: cities ?? this.cities,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'citySelected': citySelected.toJson(),
      'cities': cities?.map((x) => x.toJson())?.toList(),
    };
  }

  factory CityState.fromMap(Map<String, dynamic> map) {
    return CityState(
      citySelected: CitySortInfo.fromJson(map['citySelected']),
      cities: List<CitySortInfo>.from(
          map['cities']?.map((x) => CitySortInfo.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CityState.fromJson(String source) =>
      CityState.fromMap(json.decode(source));
}
