import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/bloc/searchcity_bloc.dart';
import 'logic/cubit/city_cubit.dart';
import 'logic/cubit/weather_cubit.dart';
import 'service/air_component_service.dart';
import 'service/city_service.dart';
import 'widget/home_page.dart';
import 'widget/screen.dart';
import 'widget/search_page.dart';
import 'widget/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AirComponentSerivce(),
        ),
        RepositoryProvider(
          create: (_) => CityService(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (blocContext) => WeatherCubit(blocContext.read())),
          BlocProvider(create: (blocContext) => CityCubit())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: SPLASH,
          routes: {
            SPLASH: (context) => SplashPage(),
            SEARCH: (context) => BlocProvider(
                create: (blocContext) => SearchCityBloc(blocContext.read()),
                child: SearchPage()),
            HOME: (context) => HomePage(),
          },
        ),
      ),
    );
  }
}
