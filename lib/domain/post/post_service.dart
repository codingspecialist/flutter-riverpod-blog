import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/response_util.dart';
import 'package:blog/domain/local/user_session.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:http/http.dart';

class PostService {
  static final PostService _instance = PostService._single();
  PostService._single();
  factory PostService() {
    return _instance;
  }

  Future<ResponseDto> findAll() async {
    Response response =
        await HttpConnector().get("/post", jwtToken: UserSession.jwtToken);
    return toResponseDto(response);
  }
}
