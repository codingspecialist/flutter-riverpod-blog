import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
import 'package:blog/model/user_session.dart';
import 'package:blog/model/user.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final HttpConnector httpConnector = HttpConnector();

  static final UserService _instance = UserService._single();
  UserService._single();
  factory UserService() {
    return _instance;
  }

  Future<ResponseDto> join(JoinReqDto joinReqDto) async {
    String requestBody = jsonEncode(joinReqDto.toJson());
    Response response = await httpConnector.post("/join", requestBody);

    return toResponseDto(response); // ResponseDto 응답
  }

  Future<ResponseDto> login(LoginReqDto loginReqDto) async {
    // 1. json 변환
    String requestBody = jsonEncode(loginReqDto.toJson());

    // 2. 통신 시작
    Response response = await httpConnector.post("/login", requestBody);

    // 3. 토큰 받기
    String jwtToken = response.headers["authorization"].toString();

    // 4. 토큰을 디바이스에 저장
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("jwtToken", jwtToken); // 자동 로그인시 필요

    // 5. ResponseDto에서 User 꺼내기
    ResponseDto responseDto = toResponseDto(response);

    // 6. AuthProvider에 로긴 정보 저장
    User user = User.fromJson(responseDto.data);
    UserSession.login(user, jwtToken);

    return responseDto; // ResponseDto 응답
  }

  Future<ResponseDto> findById(int id) async {
    Response response = await httpConnector.get("/user/$id");
    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      // 통신이 성공했을 때만 파싱을 해줘야 한다.
      responseDto.data = User.fromJson(responseDto.data);
    }
    return responseDto;
  }
}
