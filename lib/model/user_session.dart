import 'package:blog/service/local_service.dart';
import 'package:blog/model/user.dart';
import 'package:logger/logger.dart';

// main 시작전에 확인이 필요해서 provider가 아닌 static으로 관리
class UserSession {
  static User? user;
  static String? jwtToken;
  static bool isLogin = false;

  static void successAuthentication(User userParam) {
    user = userParam;
    isLogin = true;
  }

  static Future<void> removeAuthentication() async {
    user = null;
    jwtToken = null;
    isLogin = false;
    await LocalService().fetchDeleteJwtToken();
    Logger().d("세션 종료 및 디바이스 토큰 삭제");
  }

  static void setJwtToken(String token) {
    jwtToken = token;
  }

  static Map<String, String> getJwtTokenHeader(Map<String, String> headers) {
    return UserSession.jwtToken == null
        ? headers
        : {...headers, "Authorization": UserSession.jwtToken!};
  }
}
