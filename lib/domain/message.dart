
import 'package:flutter/cupertino.dart';
import 'package:ws/dto/message_dto.dart';
import 'package:ws/misc/util.dart';

import 'owner.dart';

class Message {
  final String date, text, user;
  final Owner owner;

  Message({this.date, @required this.text, this.user, @required this.owner})
      : assert(text != null), assert(owner != null);

  @override
  int get hashCode => text.hashCode;

  @override
  bool operator ==(other) => other is Message && other.text == text &&
          other.date == date && other.user == user && other.owner == owner;

  @override
  String toString() => text;
}

extension MessageExt on Message {

  bool get hasDate => isNotEmpty(date);
  bool get isMine => owner.me;

  static Message of(MessageDto dto, String user) => Message(
      date: dto.date,
      text: dto.text,
      user: dto.user,
      owner: dto.user == user ? Owner.Me
            : (isEmpty(dto.user) ? Owner.System : Owner.Other)
  );

}