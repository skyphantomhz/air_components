import 'dart:async';
import 'dart:io';

import 'package:air_components/bloc/observer_bloc.dart';
import 'package:air_components/bloc/search_city_bloc.dart';
import 'package:air_components/util/locator.dart';
import 'package:air_components/widget/home_page.dart';
import 'package:air_components/widget/search_page.dart';
import 'package:air_components/widget/splash_page.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(
    BlocProvider<ObserverBloc>(
      creator: (_context, _bag) => ObserverBloc(),
      child: BlocProvider<SearchCityBloc>(
        creator: (_context, _bag) => SearchCityBloc(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashPage(),
        '/search': (context) => SearchPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
