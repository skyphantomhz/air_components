import 'dart:convert';

import 'package:air_components/model/city/city_sort_info.dart';
import 'package:air_components/model/city/search_response.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class CityService {
  final http.Client client = GetIt.I<http.Client>();
  final _decoder = GetIt.I<JsonDecoder>();
  final baseRequest = "https://api.waqi.info/nsearch/full/";

  Future<List<CitySortInfo>> searchCity(String keyword) async {
    try {
      final response = await client
          .get(Uri.parse(baseRequest + Uri.encodeComponent(keyword)));
      if (response.statusCode == 200) {
        final responseObject =
            SearchResponse.fromJson(_decoder.convert(response.body));
        return responseObject.results;
      } else {
        throw Exception("Failed to load route");
      }
    } catch (ex) {
      print("exception ${ex.toString()}");
      throw ex;
    }
  }
}
