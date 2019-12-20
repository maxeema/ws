import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../conf.dart';
import '../models/message.dart';
import '../models/user.dart';
import '../widgets/message_input.dart';
import '../widgets/message_list.dart';

class ChatScreen extends StatefulWidget {

  final User user;

  ChatScreen(this.user);

  @override
  _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {

  IOWebSocketChannel channel;
  TextEditingController textEditingController;
  List<Message> messages = [];
  ConnectionState state;

  @override
  void initState() {
    super.initState();
    connect();
    textEditingController = TextEditingController();
  }
  void connect() {
    channel = IOWebSocketChannel.connect('ws://${Conf.host}?name=${widget.user.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: StreamBuilder(
                stream: channel.stream,
                builder: onStreamBuildWidget,
              ),
            ),
            Expanded(
              child: MessageInput(
                textEditingController: textEditingController,
                onPressed: _sendMessage,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  void _sendMessage() {
    final msg = jsonEncode({"text": textEditingController.text.trim()});
    print('_sendMessage: $msg');
    channel.sink.add(msg);
    textEditingController.clear();
  }

  Widget onStreamBuildWidget(BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
    print('onStreamBuildWidget'
        '\nconnection: ${snapshot.connectionState},'
        '\nsnapshot: $snapshot');
    state = snapshot.connectionState;
    if (snapshot.hasData) {
      final msg = Message.fromJson(jsonDecode(snapshot.data));
      msg.isMine = msg.name == widget.user.name;
      return MessageList(messages..add(msg));
    }
    switch (state) {
        case ConnectionState.waiting:
          return Center(
            child: SizedBox.fromSize(child: CircularProgressIndicator(), size: Size(40, 40),),
          );
        default:
          return Column(
              children: [
                Icon(Icons.info, color: Colors.red, size: 60,),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Wrap(
                    children: <Widget>[
                      Text("${state ?? ''}"
                          "${snapshot.hasError ? '\n\n${snapshot.error}' : ''}")
                    ],
                  ),
                )
              ]
          );
    }
  }

}
