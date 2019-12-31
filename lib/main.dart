import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:ws/state/AppState.dart';

import 'conf.dart' as conf;
import 'localizations/localization.dart';
import 'ui/chat_screen.dart';

//
void main() async {
  await AppState.init();
  runApp(MyApp());
}
//

class MyApp extends StatelessWidget {

  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: ChatScreen(
          user: AppState.get().user,
          channel: IOWebSocketChannel.connect(
            'ws://${conf.api_host}/ws?name=${AppState.get().user.name}'
          )
        ),
      ),
      //
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
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
