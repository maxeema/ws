import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'conf.dart' as conf;
import 'localizations/localization.dart';
import 'model/user.dart';
import 'ui/chat_screen.dart';

///

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final user = User("me");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //
      home: SafeArea(
        child: ChatScreen(
            user: user,
            channel: IOWebSocketChannel.connect('ws://${conf.api_url}/ws?name=${user.name}')
        )
      ),
      //
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).appTitle,
      //
      localizationsDelegates: [
        AppLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizationsDelegate.supportedLocales,
      //
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: conf.appColor,
        accentColor: conf.appAccentColor,
      ),
    );
  }

}
