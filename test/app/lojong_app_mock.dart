import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lojong_test_app/app/theme/theme.dart';
import 'package:lojong_test_app/utils/extensions/context_extensions.dart';

class LojongAppMock extends StatelessWidget {
  final Widget home;

  const LojongAppMock({required this.home, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home,
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: (context) => context.l10n.appTitle,
    );
  }
}
