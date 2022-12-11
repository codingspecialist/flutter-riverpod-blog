import 'package:blog/service/local_service.dart';
import 'package:blog/model/user.dart';
import 'package:logger/logger.dart';

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
    await LocalService().fetchDeleteJwtToken();
    Logger().d("세션 종료 및 디바이스 토큰 삭제");
  }

  static Map<String, String> getTokenHeader(Map<String, String> headers) {
    return UserSession.jwtToken == null
        ? headers
        : {...headers, "Authorization": UserSession.jwtToken!};
  }
}
