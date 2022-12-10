import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/domain/local/user_model.dart';
import 'package:blog/domain/user/user.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/core/util/response_util.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApiRepository {
  static final UserApiRepository _instance = UserApiRepository._single();

  UserApiRepository._single();
  factory UserApiRepository() {
    return _instance;
  }

  Future<ResponseDto> join(JoinReqDto joinReqDto) async {
    String requestBody = jsonEncode(joinReqDto.toJson());
    Response response = await HttpConnector().post("/join", requestBody);
    return toResponseDto(response); // ResponseDto 응답
  }

  Future<ResponseDto> login(LoginReqDto loginReqDto) async {
    // 1. json 변환
    String requestBody = jsonEncode(loginReqDto.toJson());

    // 2. 통신 시작
    Response response = await HttpConnector().post("/login", requestBody);

    // 3. 토큰 받기
    String jwtToken = response.headers["authorization"].toString();
    Logger().d(jwtToken);

    // 4. 토큰을 디바이스에 저장
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("jwtToken", jwtToken); // 자동 로그인시 필요

    // 5. ResponseDto에서 User 꺼내기
    ResponseDto responseDto = toResponseDto(response);

    // 6. AuthProvider에 로긴 정보 저장
    User user = User.fromJson(responseDto.data);
    UserModel.login(user, jwtToken);

    return responseDto; // ResponseDto 응답
  }
}
