import 'package:blog/domain/local/local_service.dart';
import 'package:blog/domain/user/user.dart';

// main 시작전에 확인이 필요해서 provider가 아닌 static으로 관리
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
    await LocalService().removeShardJwtToken();
  }
}
