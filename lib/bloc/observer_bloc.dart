import '../model/main_request/city.dart';
import '../model/main_request/iaqi.dart';
import '../model/main_request/msg.dart';
import '../service/air_component_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObserverBloc {
  AirComponentSerivce airService = AirComponentSerivce();

  PublishSubject<Exception> _exception = PublishSubject();
  Stream<Exception> get exception => _exception.stream;

  PublishSubject<City> _city = PublishSubject();
  Stream<City> get city => _city.stream;

  PublishSubject<int> _aqi = PublishSubject();
  Stream<int> get aqi => _aqi.stream;

  PublishSubject<List<Iaqi>> _iaqi = PublishSubject();
  Stream<List<Iaqi>> get iaqi => _iaqi.stream;

  PublishSubject<bool> _isLoading = PublishSubject();
  Stream<bool> get isLoading => _isLoading.stream;

  PublishSubject<String> _updateStatus = PublishSubject();
  Stream<String> get updateStatus => _updateStatus.stream;

  void fetchData(int explicitCityId) async {
    var cityId =
        explicitCityId == null ? await getSelectedCity() : explicitCityId;
    _observerAirComponent(cityId);
  }

  void _observerAirComponent(int id) async {
    try {
      _isLoading.add(true);
      Msg response = await airService.fetchData(id);
      if (response == null) {
        response = await airService.fetchData(id);
      }
      _updateStatus.sink.add(response?.time?.s?.en?.time);
      _city.sink.add(response?.city);
      _aqi.sink.add(response?.aqi);
      _iaqi.sink.add(response?.iaqi);
    } catch (ex) {
      print("Error here: " + ex.toString());
    }
    _isLoading.add(false);
  }

  @override
  void dispose() {
    _exception.close();
    _city.close();
    _aqi.close();
    _updateStatus.close();
    _iaqi.close();
  }

  Future<int> getSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('cityId') ?? 1584;
  }
}
