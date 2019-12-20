import 'package:flutter/material.dart';

import 'src/models/user.dart';
import 'src/screens/chat_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ws',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: ChatScreen(User("Me")),
    );
  }

}
