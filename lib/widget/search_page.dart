import '../logic/bloc/searchcity_bloc.dart';
import '../logic/cubit/city_cubit.dart';
import '../util/aqi_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  TextEditingController _textController = TextEditingController();

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
                          print("input keyword: $keyWord");
                          context
                              .read<SearchCityBloc>()
                              .add(SearchCityEvent(keyWord));
                        },
                        onSubmitted: (keyWord) {
                          context
                              .read<SearchCityBloc>()
                              .add(SearchCityEvent(keyWord));
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
                child: Builder(
                  builder: (context) {
                    final state = context.watch<SearchCityBloc>().state;
                    if (state is SearchFailed) {
                      return Center(child: Text(state.message));
                    } else if (state is SearchResult &&
                        state.cities != null &&
                        state.cities.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.cities.length,
                        itemBuilder: (context, index) {
                          final item = state.cities[index];
                          int itemAqi;
                          try {
                            itemAqi = int.parse(item.s.aqi);
                          } on FormatException {}
                          return InkWell(
                            onTap: () {
                              context.read<CityCubit>().addCity(item);
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
                    } else {
                      return Center(
                        child: Text("Not found"),
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
