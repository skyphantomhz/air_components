import 'package:air_components/model/city/city_sort_info.dart';
import 'package:air_components/service/city_service.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchCityBloc extends Bloc {
  CityService _cityService = GetIt.I<CityService>();

  PublishSubject<List<CitySortInfo>> _cities =
      PublishSubject<List<CitySortInfo>>();
  Stream<List<CitySortInfo>> get cities => _cities.stream;

  PublishSubject<int> _navigateToMain = PublishSubject<int>();
  Stream<int> get navigateToMain => _navigateToMain.stream;

  PublishSubject<String> _keyword = PublishSubject<String>();
  Stream<String> get keyword => _keyword.stream;

  @override
  void dispose() {
    _cities.close();
    _navigateToMain.close();
    _keyword.close();
  }

  void listener() {
    keyword.debounceTime(Duration(milliseconds: 500)).listen((keyword) {
      _search(keyword);
    });
  }

  void keyWordChange(String keyword) {
    _keyword.sink.add(keyword);
  }

  void _search(String keyword) async {
    if (keyword == null || keyword?.length == 0) return;
    List<CitySortInfo> response = await _cityService.searchCity(keyword);
    try {
      _cities.sink.add(response);
    } catch (err) {
      print("Error: " + err.toString());
    }
  }

  void selectCity(int cityId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cityId', cityId);
    _navigateToMain.add(cityId);
  }
}
