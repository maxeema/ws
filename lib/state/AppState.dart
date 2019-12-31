
import 'package:ws/domain/user.dart';

class AppState {

  static AppState _$;
  static AppState get() => _$;

  AppState._();

  User _user;
  User get user => _user;


  static Future<void> init() async {
    if (_$ != null)
      return Future.value(_$);
    //TODO restore state from storage
    _$ = AppState._();
    _$._user = User("me");
  }

}
