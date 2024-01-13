import 'package:flutter/material.dart';

import 'app/lojong_app.dart';
import 'utils/service_locator/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  runApp(const LojongApp());
}
