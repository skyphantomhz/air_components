import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/main_request/msg.dart';
import '../model/main_request/observer_response.dart';

class AirComponentSerivce {
  final http.Client client = http.Client();
  final _decoder = JsonDecoder();
  final baseRequest = "https://api.waqi.info/api/feed";

  Future<Msg> fetchData(int id) async {
    final response =
        await client.get(Uri.parse(baseRequest + "/@$id/obs.vn.json"));
    if (response.statusCode == 200) {
      final responseObject =
          ObserverResponse.fromJson(_decoder.convert(response.body));
      print(responseObject.rxs.obs.first.msg);
      return responseObject.rxs.obs.first.msg;
    } else {
      throw Exception("Failed to load route");
    }
  }
}
