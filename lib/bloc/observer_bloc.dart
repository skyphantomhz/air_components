import 'package:air_components/model/main_request/msg.dart';
import 'package:air_components/service/air_component_service.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ObserverBloc extends Bloc{
  AirComponentSerivce airService = AirComponentSerivce();
  PublishSubject<Msg> _msg = PublishSubject();
  Observable<Msg> msg() => _msg.stream;

  void observerAirComponent(int id) async {
    final response = await airService.fetchData(id);
    _msg.sink.add(response);
  }

  @override
  void dispose() {
    _msg.close();
  }
}