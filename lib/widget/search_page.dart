import 'package:air_components/bloc/search_city_bloc.dart';
import 'package:air_components/model/city/city_sort_info.dart';
import 'package:air_components/util/aqi_util.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchCityBloc bloc;
  TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    bloc = BlocProvider.of<SearchCityBloc>(context);
    bloc.listener();
    bloc.navigateToMain.listen((cityId) {
      if (cityId != null) {
        Navigator.pop(context, cityId);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3,
                        offset: Offset(0, 1))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black54,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Input your city name",
                            fillColor: Colors.white,
                            filled: true),
                        onChanged: (keyWord) {
                          bloc.keyWordChange(keyWord);
                        },
                        onSubmitted: (keyWord) {
                          bloc.keyWordChange(keyWord);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      color: Colors.black54,
                      onPressed: () {
                        _textController.clear();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<List<CitySortInfo>>(
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
                            itemAqi = int.parse(item.s.aqi);
                          } on FormatException {}
                          return InkWell(
                            onTap: () {
                              bloc.selectCity(item.x);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                              ),
                              // color: Colors.amber,
                              child: ListTile(
                                leading: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: aqiColor(itemAqi),
                                      shape: BoxShape.circle),
                                  alignment: Alignment.center,
                                  child: Text(
                                    item.s.aqi,
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
