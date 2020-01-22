import 'package:air_components/bloc/search_city_bloc.dart';
import 'package:air_components/model/city/city_sort_info.dart';
import 'package:air_components/util/aqi_util.dart';
import 'package:air_components/widget/home_page.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchCityBloc>(context);
    bloc.navigateToMain.listen((cityId) {
      if (cityId != null) {
        Navigator.pop(context);
        Navigator.pushNamed(
          context,
          "/main",
          arguments: HomeArguments(cityId),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Input your city name",
              filled: true),
          onSubmitted: (keyWord) {
            bloc.search(keyWord);
          },
        ),
      ),
      body: StreamBuilder<List<CitySortInfo>>(
          stream: bloc.cities,
          builder: (context, snapshot) {
            final data = snapshot?.data;
            if (data == null) {
              return Container();
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  int itemAqi;
                  try {
                    itemAqi = int.parse(item.s.a);
                  } on FormatException {
                    print('Format error!');
                  }
                  return InkWell(
                    onTap: () {
                      bloc.selectCity(item.x);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Colors.amber,
                      child: ListTile(
                        leading: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: aqiColor(itemAqi), shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Text(
                            item.s.a,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(item.n.join(", ")),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
