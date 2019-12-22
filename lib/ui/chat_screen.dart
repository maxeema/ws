import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:ws/conf.dart' as conf;
import 'package:ws/dto/message_dto.dart';
import 'package:ws/misc/ext.dart';
import 'package:ws/misc/insets.dart';
import 'package:ws/misc/util.dart' as util;
import 'package:ws/model/message.dart';
import 'package:ws/model/user.dart';

import 'widgets/chat_input_widget.dart';
import 'widgets/chat_message_widget.dart';

class ChatScreen extends StatefulWidget {

  final User user;

  ChatScreen(this.user);

  @override
  _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {

  final _messages = <Message>[];
  final _listKey = GlobalKey<AnimatedListState>();
  final _scrollController = ScrollController();

  IOWebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    if (_channel == null)
      _channel = IOWebSocketChannel.connect('ws://${conf.api_url}/ws?name=${user.name}');
  }

  @override
  void dispose() {
    _channel?.sink?.close(status.goingAway);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder(
        stream: _channel.stream,
        builder: onStreamBuildWidget,
      ),
    );
  }

  bool _sendMessage(String msg) {
    final json = jsonEncode({"text": msg});
    _channel.sink.add(json);
    print('send: $json');
    return true;
  }

  Widget onStreamBuildWidget(BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
    final state = snapshot.connectionState;
    print('state: $state');
    //
    if (snapshot.hasData) {
      final msg = getMessage(snapshot.data);
      _messages.add(msg);
      Future(insertMessage);
      if (msg.isMine)
        Future.delayed(50.ms, scrollToLastMessage);
      return Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: 0,
              controller: _scrollController,
              itemBuilder: (ctx, idx, animation) {
                final item = MessageItem(msg: _messages[idx]);
                if (idx == _messages.lastIndex)
                  Future(scrollToLastMessage);
                return FadeTransition(child: item, opacity: animation);
              }
            ),
          ),
          Material(
            elevation: 2,
            child: ChatInput(onOkay: _sendMessage),
          )
        ],
      );
    }
    //
    if (snapshot.hasError) {
      return Column(
          children: [
            Icon(Icons.info, color: Colors.red, size: 60,),
            Padding(
                padding: 8.insets.all,
                child: Text("${state ?? ''}"
                    "${snapshot.hasError ? '\n\n${snapshot.error}' : ''}")
            ),
          ]
      );
    }
    //
    return Center(
      child: CircularProgressIndicator()
    );
  }

  insertMessage() {
    _listKey.currentState.insertItem(_messages.lastIndex);
  }
  scrollToLastMessage() {
    if (_scrollController.hasClients)
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: 300.ms, curve: Curves.easeOut);
  }

  User get user => widget.user;

  Message getMessage(dynamic json) {
    final dto = MessageDto.fromJson(jsonDecode(json));
    Owner owner;
    if (dto.user == user.name) {
      owner = Owner.Me;
    } else if (util.isEmpty(dto.user)) {
      owner = Owner.System;
    } else {
      owner = Owner.Other;
    }
    return MessageExt.of(dto, owner);
  }

}
