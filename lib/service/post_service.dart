import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
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
    } else {
      responseDto.data = [];
    }

    return responseDto;
  }

  Future<ResponseDto> findById(int postId) async {
    Response response = await httpConnector.get("/post/${postId}");
    ResponseDto responseDto = toResponseDto(response);
    if (responseDto.code == 1) {
      responseDto.data = Post.fromJson(responseDto.data);
    } else {
      responseDto.data = {};
    }
    return responseDto;
  }

  Future<ResponseDto> deleteById(int postId) async {
    Response response = await httpConnector.delete("/post/${postId}");
    return toResponseDto(response);
  }
}
