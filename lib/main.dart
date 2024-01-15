import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/lojong_app.dart';
import 'utils/service_locator/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    initializeDependencies()
  ]);
  runApp(const LojongApp());
}
