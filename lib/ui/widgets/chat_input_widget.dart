import 'package:flutter/material.dart';
import 'package:ws/conf.dart' as conf;
import 'package:ws/misc/ext.dart';
import 'package:ws/misc/insets.dart';
import 'package:ws/misc/util.dart' as util;

typedef OnTextOkCallback = bool Function(String text);

class ChatInput extends StatelessWidget {

  ChatInput({
    Key key,
    @required this.onDone
  }) : assert (onDone != null), super(key: key);

  final OnTextOkCallback onDone;

  final _textController = TextEditingController();
  String _text;

  @override
  Widget build(BuildContext context) =>
    StatefulBuilder(
      builder: (ctx, StateSetter setState) =>
        Row(
        children: [
          Expanded(
            flex: 9,
            child: TextField(
              controller: _textController,
              scrollPadding: 16.insets.all,
              showCursor: true,
  //            autofocus: true,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              cursorColor: conf.appColor.shade200,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: context.l.messageHint,
              ),
              onSubmitted: (text) => _onDone(setState),
              onChanged: (newText) {
                setState(() {
                  _text = newText?.trim();
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            icon: Icon(Icons.send),
            onPressed: util.isNotEmpty(_text)? () => _onDone(setState) : null,
            tooltip: context.l.send,
          )
        ],
      )
    );

  _onDone(setState) {
    final consumed = onDone(_text.trim());
    if (consumed) {
      _textController.clear();
      setState(() {
        _text = "";
      });
    }
  }

}
