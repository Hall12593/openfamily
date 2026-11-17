import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  /// The localized strings for this context. Falls back to English when no
  /// localizations delegate is installed above the widget (widget tests).
  AppLocalizations get l10n =>
      AppLocalizations.of(this) ?? lookupAppLocalizations(const Locale('en'));
}
