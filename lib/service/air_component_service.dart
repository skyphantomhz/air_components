import 'dart:convert';

import 'package:air_components/model/main_request/msg.dart';
import 'package:air_components/model/main_request/observer_response.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class AirComponentSerivce {
  final http.Client client = GetIt.I<http.Client>();
  final _decoder = GetIt.I<JsonDecoder>();
  final baseRequest = "https://api.waqi.info/api/feed";

  Future<Msg> fetchData(int id) async {
    try {
      final response = await client.get(baseRequest +"/@$id/obs.vn.json");
      if (response.statusCode == 200) {
        final responseObject =
            ObserverResponse.fromJson(_decoder.convert(response.body));
            print(responseObject.rxs.obs.first.msg);
        return responseObject.rxs.obs.first.msg;
      } else {
        throw Exception("Failed to load route");
      }
    } catch (ex) {
      print("exception ${ex.toString()}");
      throw ex;
    }
  }
}
