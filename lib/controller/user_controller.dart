import 'package:blog/core/constant/routers.dart';
import 'package:blog/domain/local/user_session_model.dart';
import 'package:blog/domain/user/user_api_repository.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:flutter/material.dart';

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

class UserController {
  final mContext = navigatorKey.currentContext;
  static final UserController _instance = UserController._single();
  final UserApiRepository userApiRepository = UserApiRepository();

  UserController._single();
  factory UserController() {
    return _instance;
  }

  Future<void> join(
      {required String username,
      required String password,
      required String email}) async {
    // 1. DTO 변환
    JoinReqDto joinReqDto =
        JoinReqDto(username: username, password: password, email: email);

    // 2. 통신 요청
    ResponseDto responseDto = await userApiRepository.join(joinReqDto);

    // 3. 비지니스 로직 처리
    if (responseDto.code == 1) {
      Navigator.popAndPushNamed(mContext!, Routers.loginForm);
      // 4. 응답된 데이터를 ViewModel에 반영해야 한다면 통신 성공시에 추가하기
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("회원가입 실패")),
      );
    }
  }

  Future<void> loginForm() async {
    Navigator.popAndPushNamed(mContext!, Routers.loginForm);
  }

  Future<void> joinForm() async {
    Navigator.popAndPushNamed(mContext!, Routers.joinForm);
  }

  Future<void> login(
      {required String username, required String password}) async {
    // 1. DTO 변환
    LoginReqDto loginReqDto =
        LoginReqDto(username: username, password: password);

    // 2. 통신 요청
    ResponseDto responseDto = await userApiRepository.login(loginReqDto);
    //3. 비지니스 로직 처리
    if (responseDto.code == 1) {
      await Navigator.of(navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(Routers.home, (route) => false);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("로그인 실패")),
      );
    }
  }

  Future<void> logout() async {
    await UserSession.logout();
    await Navigator.of(navigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(Routers.loginForm, (route) => false);
  }
}
