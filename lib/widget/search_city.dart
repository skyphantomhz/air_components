import 'package:flutter/material.dart';

class SearchCity extends StatefulWidget {
  SearchCity({Key key}) : super(key: key);

  @override
  _SearchCityState createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.amber),
          child: TextField(
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "City name",
                hintText: "Input your city name",
                filled: true),
          ),
        )
      ],
    );
  }
}
