import 'dart:convert';

import 'package:blog/model/user_session.dart';
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

  // 최초 자동 로그인시에 세션이 없기 때문에 jwtToken을 storage에서 가져와서 세션 초기화함.
  Future<Response> getInitSession(String path, String? jwtToken) async {
    Map<String, String> requestHeader = {
      ...headers,
      "Authorization": jwtToken!
    };
    Uri uri = Uri.parse("${host}${path}");
    Response response = await Client().get(uri, headers: requestHeader);
    return response;
  }

  Future<Response> get(String path) async {
    Map<String, String> requestHeader = UserSession.getJwtTokenHeader(headers);
    Uri uri = Uri.parse("${host}${path}");
    Response response = await Client().get(uri, headers: requestHeader);

    return response;
  }

  Future<Response> delete(String path) async {
    Map<String, String> requestHeader = UserSession.getJwtTokenHeader(headers);
    Uri uri = Uri.parse("${host}${path}");
    Response response = await Client().delete(uri, headers: requestHeader);
    return response;
  }

  Future<Response> put(String path, String body) async {
    Map<String, String> requestHeader = UserSession.getJwtTokenHeader(headers);
    Uri uri = Uri.parse("${host}${path}");
    Response response =
        await Client().put(uri, body: body, headers: requestHeader);
    return response;
  }

  Future<Response> post(String path, String body) async {
    Map<String, String> requestHeader = UserSession.getJwtTokenHeader(headers);
    Uri uri = Uri.parse("${host}${path}");
    Response response =
        await Client().post(uri, body: body, headers: requestHeader);
    return response;
  }
}
