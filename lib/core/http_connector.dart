import 'package:http/http.dart';
import 'package:logger/logger.dart';

class HttpConnector {
  final host = "http://192.168.0.2:8080";
  final headers = {"Content-Type": "application/json; charset=utf-8"};
  static final HttpConnector _instance = HttpConnector._single();
  factory HttpConnector() {
    Logger().d("HttpConnector 생성자");
    return _instance;
  }
  HttpConnector._single();

  Future<Response> get(String path, {String? jwtToken}) async {
    if (jwtToken != null) {
      headers["Authorization"] = jwtToken;
    }
    Logger().d("${headers}");
    Uri uri = Uri.parse("${host}${path}");
    Response response = await Client().get(uri, headers: headers);
    return response;
  }

  Future<Response> delete(String path, {String? jwtToken}) async {
    if (jwtToken != null) {
      headers["Authorization"] = jwtToken;
    }
    Uri uri = Uri.parse("${host}${path}");
    Response response = await Client().delete(uri, headers: headers);
    return response;
  }

  Future<Response> put(String path, String body, {String? jwtToken}) async {
    if (jwtToken != null) {
      headers["Authorization"] = jwtToken;
    }
    Uri uri = Uri.parse("${host}${path}");
    Response response = await Client().put(uri, body: body, headers: headers);
    return response;
  }

  Future<Response> post(String path, String body, {String? jwtToken}) async {
    if (jwtToken != null) {
      headers["Authorization"] = jwtToken;
    }
    Uri uri = Uri.parse("${host}${path}");
    Response response = await Client().post(uri, body: body, headers: headers);
    return response;
  }
}
