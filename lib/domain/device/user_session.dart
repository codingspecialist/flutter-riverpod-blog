import 'package:blog/domain/device/local_repository.dart';
import 'package:blog/domain/user/user.dart';

class UserSession {
  static User? user;
  static String? jwtToken;
  static bool isLogin = false;

  static void login(User userParam, String jwtTokenParam) {
    user = userParam;
    jwtToken = jwtTokenParam;
    isLogin = true;
  }

  static Future<void> logout() async {
    user = null;
    jwtToken = null;
    isLogin = false;
    await LocalRepository.removeShardJwtToken();
  }
}
