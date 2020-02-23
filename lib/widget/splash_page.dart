import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final scheduleNavigate = const Duration(seconds: 7);

  Timer timer;

  @override
  void initState() {
    timer?.cancel();
    timer = new Timer.periodic(scheduleNavigate, (Timer t) {
      if (mounted) {
        timer?.cancel();
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: 500,
        height: 500,
        child: FlareActor("assets/flare/intro.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "intro"),
      ),
    ));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
