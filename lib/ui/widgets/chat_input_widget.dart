import 'package:flutter/material.dart';
import 'package:ws/conf.dart' as conf;
import 'package:ws/misc/ext.dart';
import 'package:ws/misc/insets.dart';
import 'package:ws/misc/util.dart' as util;

typedef OnTextOkCallback = bool Function(String text);

class ChatInput extends StatefulWidget {

  final OnTextOkCallback onOkay;

  ChatInput({@required this.onOkay}) : assert (onOkay != null);

  @override
  _ChatInputState createState() => _ChatInputState();

}

class _ChatInputState extends State<ChatInput> {

  final _textController = TextEditingController();

  FocusNode _focusNode;
  String _text;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: TextField(
            controller: _textController,
            focusNode: _focusNode,
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
            onSubmitted: (text) => onDone(),
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
          onPressed: util.isNotEmpty(_text)? onDone : null,
          tooltip: l.send,
        )
      ],
    );
  }

  onDone() {
    final consumed = widget.onOkay(_text.trim());
    if (consumed) {
      _textController.clear();
      setState(() {
        _text = "";
      });
    }
  }

}
