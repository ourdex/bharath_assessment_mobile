#!/bin/sh

# in windows, the slash is different
dart_header="///@dart=2.18"
case "$OSTYPE" in darwin*)
    dart_header="//@dart=2.18"
    ;;
esac

flutter gen-l10n \
    --arb-dir=l10n \
    --output-dir=lib/l10n/gen \
    --no-synthetic-package \
    --template-arb-file=intl_en.arb \
    --output-localization-file=app_localizations.dart \
    --output-class=AppLocalizations \
    --untranslated-messages-file=untranslated \
    --preferred-supported-locales=en \
    --preferred-supported-locales=es \
    --header=$dart_header
