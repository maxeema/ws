import 'package:flutter/material.dart';
import 'package:ws/conf.dart' as conf;
import 'package:ws/misc/ext.dart';
import 'package:ws/misc/insets.dart';
import 'package:ws/misc/util.dart' as util;

typedef OnTextOkCallback = bool Function(String text);

class ChatInput extends StatefulWidget {

  ChatInput({
    Key key,
    @required this.onDone
  }) : assert (onDone != null), super(key: key);

  final OnTextOkCallback onDone;

  @override
  _ChatInputState createState() => _ChatInputState();

}

class _ChatInputState extends State<ChatInput> {

  final _textController = TextEditingController();

  String _text;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              hintText: l.messageHint,
            ),
            onSubmitted: (text) => _onDone(),
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
          onPressed: util.isNotEmpty(_text)? _onDone : null,
          tooltip: l.send,
        )
      ],
    );
  }

  _onDone() {
    final consumed = widget.onDone(_text.trim());
    if (consumed) {
      _textController.clear();
      setState(() {
        _text = "";
      });
    }
  }

}
