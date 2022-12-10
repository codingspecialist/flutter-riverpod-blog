import 'package:blog/core/http_connector.dart';
import 'package:blog/core/util/response_util.dart';
import 'package:blog/domain/local/user_session_model.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:http/http.dart';

class PostRepository {
  static final PostRepository _instance = PostRepository._single();
  PostRepository._single();
  factory PostRepository() {
    return _instance;
  }

  Future<ResponseDto> findAll() async {
    Response response =
        await HttpConnector().get("/post", jwtToken: UserSession.jwtToken);
    return toResponseDto(response);
  }
}
