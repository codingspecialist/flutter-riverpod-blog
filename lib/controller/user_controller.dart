import 'package:blog/core/routers.dart';
import 'package:blog/domain/device/user_session.dart';
import 'package:blog/domain/user/user.dart';
import 'package:blog/domain/user/user_api_repository.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/**
 * View -> Controller 요청
 * Controller -> Repository 요청
 * Repository -> 스프링서버 요청
 * Controller -> ViewModel 응답
 * 
 * 
 * Controller 책임 : View요청 받고, 
 *                  Repository에게 통신요청하고, 
 *                  비지니스 로직 처리(페이지이동, 알림창, ViewModel 데이터 담기)
 * Repository 책임 : 통신하고, 파싱하기
 * ViewModel 책임 : 데이터 담기
 */

final userController = Provider<UserController>((ref) {
  return UserController(ref);
});

class UserController {
  UserController(this._ref);
  Ref _ref;
  final context = navigatorKey.currentContext!;

  Future<void> join(
      {required String username,
      required String password,
      required String email}) async {
    // 1. DTO 변환
    JoinReqDto joinReqDto =
        JoinReqDto(username: username, password: password, email: email);

    // 2. 통신 요청
    ResponseDto responseDto =
        await _ref.read(userApiRepository).join(joinReqDto);

    // 3. 비지니스 로직 처리
    if (responseDto.code == 1) {
      User user = User.fromJson(responseDto.data);
      print("가입된 유저 이름 : ${user.username}");
      Navigator.popAndPushNamed(context, Routers.loginForm);
      // 4. 응답된 데이터를 ViewModel에 반영해야 한다면 통신 성공시에 추가하기
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("회원가입 실패")),
      );
    }
  }

  Future<void> loginForm() async {
    Navigator.popAndPushNamed(context, Routers.loginForm);
  }

  Future<void> joinForm() async {
    Navigator.popAndPushNamed(context, Routers.joinForm);
  }

  Future<void> login(
      {required String username, required String password}) async {
    // 1. DTO 변환
    LoginReqDto loginReqDto =
        LoginReqDto(username: username, password: password);

    // 2. 통신 요청
    ResponseDto responseDto =
        await _ref.read(userApiRepository).login(loginReqDto);

    // 3. 비지니스 로직 처리
    if (responseDto.code == 1) {
      Logger().d("code 1");
      Navigator.pushNamed(context, Routers.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 실패")),
      );
    }
  }

  Future<void> logout() async {
    UserSession.logout();
  }
}
