import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final userApiRepository = Provider<UserApiRepository>((ref) {
  return UserApiRepository(ref);
});

class UserApiRepository {
  UserApiRepository(this._ref);
  Ref _ref;

  Future<ResponseDto> join(JoinReqDto joinReqDto) async {
    String requestBody = jsonEncode(joinReqDto.toJson());

    Response response =
        await _ref.read(httpConnector).post("/join", requestBody);

    Map<String, dynamic> responseMap = jsonDecode(response.body); // 문자열 -> Map

    ResponseDto responseDto =
        ResponseDto.fromJson(responseMap); // Map -> Dart Class
    return responseDto; // ResponseDto 응답
  }
}
