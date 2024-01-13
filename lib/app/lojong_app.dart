import 'package:flutter/material.dart';
import 'package:lojong_test_app/app/theme/theme.dart';

class LojongApp extends StatelessWidget {
  const LojongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
    );
  }
}
