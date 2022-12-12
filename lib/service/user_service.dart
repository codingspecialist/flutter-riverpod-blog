import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
import 'package:blog/model/session_user.dart';
import 'package:blog/model/user.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class UserService {
  final HttpConnector httpConnector = HttpConnector();

  static final UserService _instance = UserService._single();
  UserService._single();
  factory UserService() {
    return _instance;
  }

  Future<ResponseDto> fetchJoin(JoinReqDto joinReqDto) async {
    String requestBody = jsonEncode(joinReqDto.toJson());
    Response response = await httpConnector.post("/join", requestBody);

    return toResponseDto(response); // ResponseDto 응답
  }

  Future<ResponseDto> fetchLogin(LoginReqDto loginReqDto) async {
    // 1. json 변환
    String requestBody = jsonEncode(loginReqDto.toJson());

    // 2. 통신 시작
    Response response = await httpConnector.post("/login", requestBody);

    // 3. 토큰 받기
    String jwtToken = response.headers["authorization"].toString();
    await secureStorage.write(key: "jwtToken", value: jwtToken);

    // 4. ResponseDto 만들기
    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      User user = User.fromJson(responseDto.data);
      responseDto.data = user;
    }

    return responseDto; // ResponseDto 응답
  }

  Future<ResponseDto> fetchUserInfo(int id, String jwtToken) async {
    Response response =
        await httpConnector.get("/user/$id", jwtToken: jwtToken);
    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      // 통신이 성공했을 때만 파싱을 해줘야 한다.
      responseDto.data = User.fromJson(responseDto.data);
    }
    return responseDto;
  }
}
