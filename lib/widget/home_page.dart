import 'package:air_components/bloc/observer_bloc.dart';
import 'package:air_components/model/main_request/city.dart';
import 'package:air_components/model/main_request/iaqi.dart';
import 'package:air_components/util/color_util.dart';
import 'package:air_components/widget/home_component/progress_arc.dart';
import 'package:air_components/widget/home_component/weather_property.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ObserverBloc>(context);
    bloc.observerAirComponent(12);
    return Scaffold(
      body: StreamBuilder<Exception>(
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
                          return Text(
                            snapshot?.data?.name ?? "N/A",
                            style: TextStyle(fontSize: 20),
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
                                child: Text(snapshot?.data?.toString() ?? "",
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
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: InkWell(
                                    onTap: () {
                                      print("Hello");
                                    },
                                    child: Text(
                                      "Moderate",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
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
                          children: _buildAirComponents(snapshot.data),
                        );
                    },
                  ),
                ],
              );
          }),
    );
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
    var currentValue = iaqi.v.first ?? 0;
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
}
