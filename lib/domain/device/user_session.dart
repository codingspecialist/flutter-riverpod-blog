import 'package:blog/domain/user/user.dart';

class UserSession {
  static User? user;
  static String? jwtToken;
  static bool isLogin = false;
}
