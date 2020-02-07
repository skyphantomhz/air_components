import 'dart:async';
import 'dart:io';

import 'package:air_components/bloc/observer_bloc.dart';
import 'package:air_components/bloc/search_city_bloc.dart';
import 'package:air_components/util/locator.dart';
import 'package:air_components/widget/home_page.dart';
import 'package:air_components/widget/search_page.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  setupLocator();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runZoned(() {
    runApp(
      BlocProvider<ObserverBloc>(
        creator: (_context, _bag) => ObserverBloc(),
        child: BlocProvider<SearchCityBloc>(
          creator: (_context, _bag) => SearchCityBloc(),
          child: MyApp(),
        ),
      ),
    );
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutter', 'great app', 'food', 'drink'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );
  BannerAd _bannerAd;

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-7567000157197488~5653744567");
    _bannerAd = createBannerAd()..load();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: "ca-app-pub-7567000157197488/8738524169",
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.logTutorialBegin();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [MyApp.observer],
      initialRoute: '/',
      routes: {
        '/search': (context) => SearchPage(),
        '/': (context) => HomePage(bannerAd: _bannerAd,),
      },
    );
  }
}
