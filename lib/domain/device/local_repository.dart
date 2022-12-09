import 'package:blog/domain/device/user_session.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  static Future<void> initShardJwtToken() async {
    Logger().d("jwt init");
    final prefs = await SharedPreferences.getInstance();
    final deviceJwtToken = prefs.getString("jwtToken");
    if (deviceJwtToken != null) {
      Logger().d("jwt 토큰 존재함 : ${deviceJwtToken}");
      UserSession.isLogin = true;
      UserSession.jwtToken = deviceJwtToken;
    } else {
      Logger().d("jwt 토큰 없음");
    }
  }
}
