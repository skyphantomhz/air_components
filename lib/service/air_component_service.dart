import 'dart:convert';

import 'package:air_components/model/main_request/msg.dart';
import 'package:air_components/model/main_request/observer_response.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class AirComponentSerivce {
  final http.Client client = GetIt.I<http.Client>();
  final _decoder = GetIt.I<JsonDecoder>();
  final baseRequest = "https://api.waqi.info/api/feed/@10763/obs.vn.json";

  Future<Msg> fetchData(int id) async {
    final response = await client.get(baseRequest);
    if (response.statusCode == 200) {
      final responseObject =
          ObserverResponse.fromJson(_decoder.convert(response.body));
      print("=================Response=====================");
      print("$responseObject");
      return responseObject.rxs.obs.first.msg;
    } else {
      throw Exception("Failed to load route");
    }
  }
}
