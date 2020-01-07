import 'dart:ui';

import 'package:flutter/material.dart';

Color aqiColor(int aqius) {
  if (aqius == null) {
    return Colors.grey;
  } else if (aqius < 51) {
    return Colors.green[400];
  } else if (aqius < 101) {
    return Colors.yellow;
  } else if (aqius < 151) {
    return Colors.orange[900];
  } else if (aqius < 201) {
    return Colors.red[900];
  } else if (aqius < 301) {
    return Colors.purple[900];
  } else {
    return Colors.brown[900];
  }
}