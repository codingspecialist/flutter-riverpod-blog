import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
import 'package:blog/model/user_session.dart';
import 'package:blog/model/user.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class LocalService {
  final HttpConnector httpConnector = HttpConnector();

  static final LocalService _instance = LocalService._single();
  LocalService._single();
  factory LocalService() {
    Logger().d("LocalRepository 생성자");
    return _instance;
  }

  Future<void> fetchJwtToken() async {
    Logger().d("jwt init");
    String? deviceJwtToken = await storage.read(key: "jwtToken");
    if (deviceJwtToken != null) {
      Response response = await httpConnector.get("/jwtToken");
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

  Future<void> fetchDeleteJwtToken() async {
    Logger().d("jwt remove");
    await storage.delete(key: "jwtToken");
  }
}
