import 'package:cross_mobile/l10n/gen/app_localizations.dart';
import 'package:cross_mobile/l10n/gen/app_localizations_en.dart';
import 'package:cross_mobile/l10n/gen/app_localizations_es.dart';

class L {
  AppLocalizations? currentLocale;

  L._();

  static AppLocalizations of(context) {
    AppLocalizations? locale;
    try {
      locale = AppLocalizations.of(context);
    } catch (ex) {
      locale ??= AppLocalizationsEn();
    }

    final codes = locale.localeName.split('_');
    if (codes.length == 1) {
      switch (codes[0]) {
        case "es":
          return AppLocalizationsEs();
        default:
          return AppLocalizationsEn();
      }
    }
    return locale;
  }
}
