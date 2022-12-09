import 'package:blog/domain/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(ref);
});

class AuthProvider {
  AuthProvider(this._ref);
  Ref _ref;
  User? user;
  String? jwtToken;
  bool isLogin = false;

  Future<bool> initJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceJwtToken = prefs.getString("jwtToken");
    if (deviceJwtToken != null) {
      Logger().d("${deviceJwtToken}");
      isLogin = true;
      Logger().d("isLogin : ${isLogin}");
      jwtToken = deviceJwtToken;
      // 통신코드로 user 초기화
      // http://ip주소:8080/userData (Get, Header:token)
    }
    Logger().d("initJwtToken 종료");
    return isLogin;
  }
}
