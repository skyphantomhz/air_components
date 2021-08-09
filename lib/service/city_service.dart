import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/city/city_sort_info.dart';
import '../model/city/search_response.dart';

class CityService {
  final http.Client client = http.Client();
  final _decoder = JsonDecoder();
  final baseRequest = "https://api.waqi.info/nsearch/full/";

  Future<List<CitySortInfo>> searchCity(String keyword) async {
    final response =
        await client.get(Uri.parse(baseRequest + Uri.encodeComponent(keyword)));
    if (response.statusCode == 200) {
      final responseObject =
          SearchResponse.fromJson(_decoder.convert(response.body));
      return responseObject.results;
    } else {
      throw Exception("Failed to load route");
    }
  }
}
