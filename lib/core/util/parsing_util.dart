import 'dart:convert';

import 'package:blog/dto/response_dto.dart';
import 'package:http/http.dart';

ResponseDto toResponseDto(Response response) {
  Map<String, dynamic> responseMap =
      jsonDecode(utf8.decode(response.bodyBytes)); // 문자열 -> Map

  ResponseDto responseDto =
      ResponseDto.fromJson(responseMap); // Map -> Dart Class

  return responseDto;
}
