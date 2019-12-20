import 'package:flutter/material.dart';

import '../models/message.dart';
import 'message_item.dart';

class MessageList extends StatelessWidget {

  final List<Message> messages;

  MessageList(messages) : assert(messages != null),
    this.messages = messages;

  final _scrollController = ScrollController();

  scrollToLastMessage() =>
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);

  @override
  Widget build(BuildContext context) {
    Future(scrollToLastMessage);
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (ctx, idx) => MessageItem(msg: messages[idx]),
      controller: _scrollController,
    );
  }

}
