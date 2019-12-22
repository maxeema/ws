import 'dart:ui';

import 'package:flutter/material.dart';

part 'objects.dart';

class AppLocalizations {

  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title':    'ws',
      'me':           'Me',
      'system_user':  'system',
      'message_hint': 'Your message...',
      'send':         'Send',
    },
  };

  Map<String, String> get _localized => _localizedValues[locale.languageCode];

  String localized(String key) => _localized[key];

  String get appTitle    => _localized['app_title'];
  String get me          => _localized['me'];
  String get systemUser  => _localized['system_user'];
  String get messageHint => _localized['message_hint'];
  String get send        => _localized['send'];
}
