import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
import 'package:blog/dto/post_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/post.dart';
import 'package:http/http.dart';

/*
 * 메서드 이름 규칙 : 동사+명사
 * 메서드 이름 짓는 법 : 컨트롤러에서 서버쪽으로 요청하는 것이기 때문에
 * fetch + 동사(알파) + 모델명 + 자유(알파)
 */

class PostService {
  final HttpConnector httpConnector = HttpConnector();

  static final PostService _instance = PostService._single();
  PostService._single();
  factory PostService() {
    return _instance;
  }

  Future<ResponseDto> fetchPostList(String jwtToken) async {
    Response response = await httpConnector.get("/post", jwtToken: jwtToken);

    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      List<dynamic> mapList = responseDto.data; // dynamic
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();
      responseDto.data = postList;
    }

    return responseDto;
  }

  Future<ResponseDto> fetchPost(int postId, String jwtToken) async {
    Response response =
        await httpConnector.get("/post/$postId", jwtToken: jwtToken);
    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      responseDto.data = Post.fromJson(responseDto.data);
    }
    return responseDto;
  }

  Future<ResponseDto> fetchDeletePost(int postId, String jwtToken) async {
    Response response =
        await httpConnector.delete("/post/$postId", jwtToken: jwtToken);
    return toResponseDto(response);
  }

  Future<ResponseDto> fetchWritePost(
      PostWriteReqDto postWriteReqDto, String jwtToken) async {
    String requestBody = jsonEncode(postWriteReqDto.toJson());
    Response response =
        await httpConnector.post("/post", requestBody, jwtToken: jwtToken);
    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      responseDto.data = Post.fromJson(responseDto.data);
    }
    return responseDto;
  }

  Future<ResponseDto> fetchUpdatePost(
      int id, PostUpdateReqDto postUpdateReqDto, String jwtToken) async {
    String requestBody = jsonEncode(postUpdateReqDto.toJson());
    Response response =
        await httpConnector.put("/post/$id", requestBody, jwtToken: jwtToken);
    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      responseDto.data = Post.fromJson(responseDto.data);
    }
    return responseDto;
  }
}
