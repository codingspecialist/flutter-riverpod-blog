import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/response_util.dart';
import 'package:blog/domain/local/user_session_model.dart';
import 'package:blog/domain/user/user.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  static final LocalRepository _instance = LocalRepository._single();

  LocalRepository._single();
  factory LocalRepository() {
    Logger().d("LocalRepository 생성자");
    return _instance;
  }

  Future<void> initShardJwtToken() async {
    Logger().d("jwt init");
    final prefs = await SharedPreferences.getInstance();
    final deviceJwtToken = prefs.getString("jwtToken");
    if (deviceJwtToken != null) {
      Response response =
          await HttpConnector().get("/user/jwtToken", jwtToken: deviceJwtToken);
      ResponseDto responseDto = toResponseDto(response);
      User user = User.fromJson(responseDto.data);
      UserSession.login(user, deviceJwtToken);
    }
  }

  Future<void> removeShardJwtToken() async {
    Logger().d("jwt remove");
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("jwtToken");
  }
}
