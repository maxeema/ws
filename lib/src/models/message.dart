
import 'package:flutter/cupertino.dart';

class Message {

  final String date,
               text,
               name;
  var isMine = false;

  Message({this.date, @required this.text, this.name, this.isMine});

  bool get isSystem => name == null;
  bool get hasDate => date != null && date.trim().isNotEmpty;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      date: json['created'],
      text: json['text'],
      name: json['name']
  );

  Map<String, dynamic> toJson() => {
    'created': date,
    'text': text,
    'name': name
  };

}
