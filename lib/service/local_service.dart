import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
import 'package:blog/model/user_session.dart';
import 'package:blog/model/user.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static final LocalService _instance = LocalService._single();

  LocalService._single();
  factory LocalService() {
    Logger().d("LocalRepository 생성자");
    return _instance;
  }

  Future<void> initShardJwtToken() async {
    Logger().d("jwt init");
    final prefs = await SharedPreferences.getInstance();
    final deviceJwtToken = prefs.getString("jwtToken");
    if (deviceJwtToken != null) {
      Response response =
          await HttpConnector().get("/jwtToken", jwtToken: deviceJwtToken);
      ResponseDto responseDto = toResponseDto(response);

      if (responseDto.code == 1) {
        User user = User.fromJson(responseDto.data);
        UserSession.login(user, deviceJwtToken);
      } else {
        Logger().d("토큰이 만료됨");
        UserSession.logout();
      }
    }
  }

  Future<void> removeShardJwtToken() async {
    Logger().d("jwt remove");
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("jwtToken");
  }
}
