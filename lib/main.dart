import 'package:flutter/material.dart';

import 'app.dart';
import 'core/app_config.dart';
import 'core/injection_container.dart' as di;

void main() async {
  AppConfig();

  // Service Locator Initialization
  await di.init();
  runApp(const MyApp());
}
