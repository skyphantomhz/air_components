import 'package:air_components/model/main_request/city.dart';
import 'package:air_components/model/main_request/iaqi.dart';
import 'package:air_components/service/air_component_service.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObserverBloc extends Bloc {
  AirComponentSerivce airService = AirComponentSerivce();

  PublishSubject<Exception> _exception = PublishSubject();
  Observable<Exception> get exception => _exception.stream;

  PublishSubject<City> _city = PublishSubject();
  Observable<City> get city => _city.stream;

  PublishSubject<int> _aqi = PublishSubject();
  Observable<int> get aqi => _aqi.stream;

  PublishSubject<List<Iaqi>> _iaqi = PublishSubject();
  Observable<List<Iaqi>> get iaqi => _iaqi.stream;

  PublishSubject<bool> _isLoading = PublishSubject();
  Observable<bool> get isLoading => _isLoading.stream;

  void fetchData(int explicitCityId) async {
    var cityId = explicitCityId == null ? await getSelectedCity() : explicitCityId;
    _observerAirComponent(cityId);
  }

  void _observerAirComponent(int id) async {
    try {
      _isLoading.add(true);
      final response = await airService.fetchData(id);
      _city.sink.add(response.city);
      _aqi.sink.add(response.aqi);
      _iaqi.sink.add(response.iaqi);
      _isLoading.add(false);
    } catch (ex) {
      print("Error here: "+ex.toString());
    }
  }

  @override
  void dispose() {
    _exception.close();
    _city.close();
    _aqi.close();
    _iaqi.close();
  }

  Future<int> getSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('cityId') ?? 1584;
  }
}
