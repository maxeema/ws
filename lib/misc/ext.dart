import 'package:flutter/material.dart';
import 'package:ws/localizations/localization.dart';

import 'util.dart' as util;

extension DurationExt on int {
  get ms => util.ms(this);
  get sec => util.sec(this);
}

extension StringExt on String {

  TimeOfDay parseTimeOfDay() => TimeOfDay.fromDateTime(DateTime.parse(this));

}

extension ListExt on List {

  int get lastIndex => length - 1;
  int get size => length;

}

extension StateExt<T extends StatefulWidget> on State<T> {

  AppLocalizations get l => AppLocalizations.of(context);

}