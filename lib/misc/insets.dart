
import 'package:flutter/widgets.dart';

extension InsetsList on List<int> {
  Insets get insets => Insets.ofList(this);
}

extension InsetsInt on int {
  Insets get insets => Insets.of(this);
}

class Insets {
  final value;
  Insets._(this.value) : assert(value != null);

  factory Insets.of(int value) => Insets._(value.toDouble());
  factory Insets.ofList(List<int> value) => Insets._(value);

  List<int> get list  => value;

  get topBottom => EdgeInsetsDirectional.only(top: list[0].toDouble(), bottom: list[1].toDouble());
  get startEnd  => EdgeInsetsDirectional.only(start: list[0].toDouble(), end: list[1].toDouble());
  get steb      => EdgeInsetsDirectional.fromSTEB(list[0].toDouble(), list[1].toDouble(), list[2].toDouble(), list[3].toDouble());

  get all   => EdgeInsets.all(value);
  get vert  => EdgeInsets.symmetric(vertical: value);
  get horz  => EdgeInsets.symmetric(horizontal: value);
  get end   => EdgeInsetsDirectional.only(end: value);
  get start => EdgeInsetsDirectional.only(start: value);
  get top   => EdgeInsetsDirectional.only(top: value);
  get bot   => EdgeInsetsDirectional.only(bottom: value);
}