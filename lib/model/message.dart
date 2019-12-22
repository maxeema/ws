
import 'package:flutter/cupertino.dart';
import 'package:ws/dto/message_dto.dart';

enum Owner {
  Me, System, Other
}

class Message {
  final String date,
               text,
               user;
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

extension OwnerExt on Owner {
  bool get me => this == Owner.Me;
  bool get system => this == Owner.System;
  bool get other => this == Owner.Other;
}

extension MessageExt on Message {

  bool get hasDate => date != null && date.trim().isNotEmpty;
  bool get isMine => owner.me;

  static Message of(MessageDto dto, Owner owner) => Message(
      date: dto.date,
      text: dto.text,
      user: dto.user,
      owner: owner
  );
  
}