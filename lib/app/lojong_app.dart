import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lojong_test_app/app/theme/theme.dart';
import 'package:lojong_test_app/utils/extensions/context_extensions.dart';

class LojongApp extends StatelessWidget {
  const LojongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: (context) => context.l10n.appTitle,
    );
  }
}
