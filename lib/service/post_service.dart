import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/parsing_util.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/post.dart';
import 'package:blog/model/response_model.dart';
import 'package:blog/model/user_session.dart';
import 'package:http/http.dart';

class PostService {
  static final PostService _instance = PostService._single();
  PostService._single();
  factory PostService() {
    return _instance;
  }

  Future<ResponseModel> findAll() async {
    Response response =
        await HttpConnector().get("/post", jwtToken: UserSession.jwtToken);
    ResponseDto responseDto = toResponseDto(response);

    List<Post> postList = [];
    if (responseDto.data != null) {
      List<dynamic> mapList = responseDto.data; // dynamic
      postList = mapList.map((e) => Post.fromJson(e)).toList();
    }

    ResponseModel responseModel =
        ResponseModel(responseDto.code, responseDto.msg, postList);
    return responseModel;
  }
}
