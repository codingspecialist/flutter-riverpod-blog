import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/post.dart';
import 'package:blog/model/user_session.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class PostService {
  static final PostService _instance = PostService._single();
  PostService._single();
  factory PostService() {
    return _instance;
  }

  Future<ResponseDto> findAll() async {
    Logger().d("유저 세션 토큰 : ${UserSession.jwtToken}");
    Response response = await HttpConnector().get("/post");

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
}
