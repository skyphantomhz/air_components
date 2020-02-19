import 'dart:async';

import 'package:air_components/bloc/observer_bloc.dart';
import 'package:air_components/model/main_request/city.dart';
import 'package:air_components/model/main_request/iaqi.dart';
import 'package:air_components/util/aqi_util.dart';
import 'package:air_components/widget/home_component/progress_arc.dart';
import 'package:air_components/widget/home_component/weather_property.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.bannerAd}) : super(key: key);
  final BannerAd bannerAd;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int sizeAttributes = 6;
  final scheduleFetch = const Duration(minutes: 5);
  bool isLoading;
  Timer timer;

  ObserverBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ObserverBloc>(context);
    _setListener(bloc, context);
    bloc.fetchData(null);
    timer?.cancel();
    timer =
        new Timer.periodic(scheduleFetch, (Timer t) => bloc.fetchData(null));
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _setListener(ObserverBloc bloc, BuildContext context) {
    bloc.isLoading.listen((value) {
      if (value == true && mounted) {
        _showDialog(context);
      } else {
        if (isLoading) {
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.bannerAd
      ..load()
      ..show();
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            bloc.fetchData(null);
          },
          child: StreamBuilder<Exception>(
              stream: bloc.exception,
              builder: (context, snapshot) {
                final exception = snapshot?.data;
                if (exception != null)
                  return Center(child: Text("${exception.toString()}"));
                else
                  return ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20),
                        child: StreamBuilder<City>(
                            stream: bloc.city,
                            builder: (context, snapshot) {
                              return InkWell(
                                onTap: () async {
                                  final result = await Navigator.pushNamed(
                                      context, "/search");
                                  if (result != null) {
                                    bloc.fetchData(result);
                                    timer?.cancel();
                                    timer = new Timer.periodic(scheduleFetch,
                                        (Timer t) => bloc.fetchData(null));
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 40),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 250),
                                        child: Text(
                                          snapshot?.data?.name ?? "N/A",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Icon(Icons.edit, size: 15))
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        height: 200.0,
                        margin: EdgeInsets.only(top: 30),
                        alignment: Alignment.topCenter,
                        child: StreamBuilder<int>(
                            stream: bloc.aqi,
                            builder: (context, snapshot) {
                              return Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: _buildArcView(snapshot),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        snapshot?.data?.toString() ?? "",
                                        style: TextStyle(
                                            fontFamily: 'AllRoundGothic',
                                            fontSize: 70)),
                                  ),
                                  Align(
                                    alignment: Alignment(0, 0.5),
                                    child: Text("AQI"),
                                  ),
                                  Align(
                                    alignment: Alignment(0, 1),
                                    child:
                                        _buildStatus(context, snapshot?.data),
                                  ),
                                ],
                              );
                            }),
                      ),
                      StreamBuilder<List<Iaqi>>(
                        stream: bloc.iaqi,
                        builder: (context, snapshot) {
                          if (snapshot?.data == null)
                            return Container();
                          else
                            return GridView.count(
                              childAspectRatio: 4,
                              crossAxisCount: 2,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              children: _buildAirComponents(
                                  _getAirComponents(snapshot.data)),
                            );
                        },
                      ),
                      StreamBuilder(
                        stream: bloc.iaqi,
                        builder: (context, snapshot) {
                          final conditions =
                              _getWeatherConditions(snapshot?.data);
                          if (snapshot?.data == null)
                            return Container();
                          else
                            return Column(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 10, 5),
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
              }),
        ),
      ),
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

  Widget buildConditionIcon(String conditionIconUrl){
    return FlareActor(conditionIconUrl, alignment:Alignment.center, fit:BoxFit.contain, animation:"Untitled");
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

  _buildArcView(AsyncSnapshot<int> snapshot) {
    var aqi = snapshot.data ?? 0;
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
