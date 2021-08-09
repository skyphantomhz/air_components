import '../logic/cubit/city_cubit.dart';

import '../logic/cubit/weather_cubit.dart';
import '../model/main_request/iaqi.dart';
import '../util/aqi_util.dart';
import 'home_component/progress_arc.dart';
import 'home_component/weather_property.dart';
import 'screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  bool isLoading;

  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.read<WeatherCubit>();
    final cityState = context.watch<CityCubit>().state;
    weatherCubit.fetchData(cityState.citySelected?.x);
    return Scaffold(
      endDrawer: Drawer(
        child: Material(
          child: Builder(builder: (builderContext) {
            final cityState = builderContext.watch<CityCubit>().state;
            final cities = cityState.cities;
            final itemCount = (cities?.length ?? 0) + 1;
            print("Item count is $itemCount");
            return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index < (cities?.length ?? 0)) {
                  final city = cities[index];
                  return Card(
                    elevation: 8,
                    child: InkWell(
                      onTap: () {
                        final cityBloc = builderContext.read<CityCubit>();
                        cityBloc.selectCity(city);
                      },
                      child: Container(
                        child: Text(
                          city.s.names.first,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      ),
                    ),
                  );
                } else {
                  return Card(
                    elevation: 8,
                    child: InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(context, SEARCH);
                      },
                      child: Container(
                        child: Icon(Icons.add),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                    ),
                  );
                }
              },
            );
          }),
        ),
      ),
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(Icons.settings)),
          )
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final cityState = context.read<CityCubit>().state;
            weatherCubit.fetchData(cityState.citySelected?.x);
          },
          child: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
            if (state is WeatherInitial) {
              return Center(
                child: Text("Please select a city"),
              );
            } else if (state is WeatherLoading) {
              return Center(
                child: Container(
                    width: 40, height: 40, child: CircularProgressIndicator()),
              );
            } else if (state is WeatherError) {
              AlertDialog(
                title: const Text('Error'),
                content: Text("Cause: ${state.message}"),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
              return Center(
                child: Text(state.message),
              );
            } else if (state is WeatherResult) {
              return _buildContentView(context, state);
            } else {
              return Center(
                child: Text("Something went wrong"),
              );
            }
          }),
        ),
      ),
    );
  }

  Widget _buildContentView(BuildContext context, WeatherResult state) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Container(
            alignment: Alignment.center,
            child: Text(
              state.city.name,
              style: Theme.of(context).textTheme.headline5,
            )),
        Container(
            height: 200.0,
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.topCenter,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: _buildArcView(state.aqi),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(state.aqi.toString() ?? "",
                      style: TextStyle(
                          fontFamily: 'AllRoundGothic', fontSize: 70)),
                ),
                Align(
                  alignment: Alignment(0, 0.5),
                  child: Text("AQI"),
                ),
                Align(
                  alignment: Alignment(0, 1),
                  child: _buildStatus(context, state.aqi),
                ),
              ],
            )),
        Builder(
          builder: (context) {
            if (state.iaqi == null)
              return Container();
            else
              return GridView.count(
                childAspectRatio: 4,
                crossAxisCount: 2,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: _buildAirComponents(_getAirComponents(state.iaqi)),
              );
          },
        ),
        Builder(
          builder: (context) {
            final conditions = _getWeatherConditions(state.iaqi);
            if (state.iaqi == null)
              return Container();
            else
              return Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Text(
                            "Weather",
                            style: TextStyle(fontSize: 15),
                          ))),
                  _buildConditions(conditions),
                ],
              );
          },
        )
      ],
    );
  }

  List<Iaqi> _getAirComponents(List<Iaqi> items) {
    return items
        ?.where((item) =>
            ["pm25", "pm10", "o3", "no2", "so2", "co"].contains(item?.p ?? ""))
        ?.toList();
  }

  List<Iaqi> _getWeatherConditions(List<Iaqi> items) {
    return items
        ?.where((item) => ["t", "p", "h", "w", "r"].contains(item?.p ?? ""))
        ?.toList();
  }

  Widget _buildConditions(List<Iaqi> conditions) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: conditions?.map((condition) {
            return _buildCondition(condition);
          })?.toList()),
    );
  }

  Widget _buildCondition(Iaqi condition) {
    return Column(
      children: <Widget>[
        Container(
            width: 50,
            height: 50,
            child: buildConditionIcon(condition.getConditionIconUrl())),
        Text(
            "${condition.v.first.toString()}${condition.getConditionUnit(true)}")
      ],
    );
  }

  Widget buildConditionIcon(String conditionIconUrl) {
    return FlareActor(conditionIconUrl,
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "Untitled");
  }

  _showDialog(BuildContext context) async {
    isLoading = true;
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            child: Center(
              child: SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator()),
            ),
          );
        });
    isLoading = false;
  }

  _buildArcView(int aqi) {
    double percent = aqi == 0 ? 0 : aqi / 300;
    var color = aqiColor(aqi);
    percent = percent > 1 ? 1 : percent;
    return Container(
      width: 200.0,
      height: 200.0,
      child: ProgressArc(
        percent: percent,
        primaryColor: color,
        secondColor: Colors.grey[200],
      ),
    );
  }

  _buildAirComponents(List<Iaqi> data) {
    final componentWidgets = List<Widget>();
    data?.forEach((item) {
      componentWidgets.add(_buildAirComponent(item));
    });
    return componentWidgets;
  }

  _buildAirComponent(Iaqi iaqi) {
    var currentValue = 0;
    if (iaqi?.v?.first.toString() != "-") {
      currentValue = iaqi?.v?.first;
    }
    double percent = currentValue == 0 ? 0 : currentValue / 300;
    var color = aqiColor(currentValue);
    percent = percent > 1 ? 1 : percent;
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(8),
      child: WeatherProperty(
        name: iaqi.p ?? "",
        value: currentValue.toDouble(),
        percent: percent,
        primaryColor: color,
        secondColor: Colors.grey[200],
        unit: "AQI",
      ),
    );
  }

  Widget _buildStatus(BuildContext context, int aqi) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      decoration: BoxDecoration(
          color: aqiColor(aqi), borderRadius: BorderRadius.circular(4)),
      child: InkWell(
        onTap: () {
          _showDialog(context);
          // Crashlytics.instance.crash();
        },
        child: Text(
          aqiStatus(aqi),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
