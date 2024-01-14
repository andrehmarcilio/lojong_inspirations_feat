import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum AppExceptionMessages {
  serverSide,
  unknown;

  String getMessage(AppLocalizations l10n) {
    return switch (this) {
      serverSide => l10n.commonsServerSideErrorMessageLabel,
      unknown => l10n.commonsDefaultErrorMessageLabel,
    };
  }
}
