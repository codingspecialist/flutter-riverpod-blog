import 'dart:convert';

import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
import 'package:blog/dto/post_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/post.dart';
import 'package:http/http.dart';

class PostService {
  final HttpConnector httpConnector = HttpConnector();

  static final PostService _instance = PostService._single();
  PostService._single();
  factory PostService() {
    return _instance;
  }

  Future<ResponseDto> findAll() async {
    Response response = await httpConnector.get("/post");

    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      List<dynamic> mapList = responseDto.data; // dynamic
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();
      responseDto.data = postList;
    }

    return responseDto;
  }

  Future<ResponseDto> findById(int postId) async {
    Response response = await httpConnector.get("/post/${postId}");
    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      responseDto.data = Post.fromJson(responseDto.data);
    }
    return responseDto;
  }

  Future<ResponseDto> deleteById(int postId) async {
    Response response = await httpConnector.delete("/post/${postId}");
    return toResponseDto(response);
  }

  Future<ResponseDto> write(PostWriteReqDto postWriteReqDto) async {
    String requestBody = jsonEncode(postWriteReqDto.toJson());
    Response response = await httpConnector.post("/post", requestBody);
    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      responseDto.data = Post.fromJson(responseDto.data);
    }
    return responseDto;
  }

  Future<ResponseDto> update(int id, PostUpdateReqDto postUpdateReqDto) async {
    String requestBody = jsonEncode(postUpdateReqDto.toJson());
    Response response = await httpConnector.put("/post/$id", requestBody);
    ResponseDto responseDto = await toResponseDto(response);
    if (responseDto.code == 1) {
      responseDto.data = Post.fromJson(responseDto.data);
    }
    return responseDto;
  }
}
