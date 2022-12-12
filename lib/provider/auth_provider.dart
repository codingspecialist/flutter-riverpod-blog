import 'package:blog/controller/post_controller.dart';
import 'package:blog/core/constant/move.dart';
import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/session_user.dart';
import 'package:blog/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

const secureStorage = FlutterSecureStorage();

final authProvider = StateNotifierProvider<AuthProvider, SessionUser>((ref) {
  return AuthProvider(SessionUser(null, null, false), ref);
});

class AuthProvider extends StateNotifier<SessionUser> {
  final mContext = navigatorKey.currentContext;
  final Ref _ref;
  AuthProvider(super.state, this._ref);

  Future<void> autoLogin() async {
    String? jwtToken = await secureStorage.read(key: "jwtToken");
    if (jwtToken != null) {
      Response response =
          await HttpConnector().get("/jwtToken", jwtToken: jwtToken);
      ResponseDto responseDto = toResponseDto(response);

      if (responseDto.code == 1) {
        Logger().d("자동 로그인 성공!!");
        User user = User.fromJson(responseDto.data);
        Logger().d("user : " + user.username);
        state = SessionUser(user, jwtToken, true);

        Navigator.pushNamedAndRemoveUntil(
            mContext!, Move.homePage, (route) => false);
      }
    }
  }

  Future<void> authentication(SessionUser sessionUser) async {
    state = sessionUser;
    await secureStorage.write(key: "jwtToken", value: sessionUser.jwtToken);
  }

  Future<void> inValidate() async {
    state = SessionUser(null, null, false);
    await secureStorage.delete(key: "jwtToken");
  }
}
