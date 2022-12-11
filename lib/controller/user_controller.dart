import 'package:blog/core/constant/move.dart';
import 'package:blog/model/user_session.dart';
import 'package:blog/service/user_service.dart';
import 'package:blog/dto/auth_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * View -> Controller 요청
 * Controller -> Service 요청
 * Service -> 스프링서버 요청
 * Controller -> ViewModel 응답
 * 
 * 
 * Controller 책임 : View요청 받고, 
 *                  Service에게 통신요청하고, 
 *                  화면 비지니스 로직 처리(페이지이동, 알림창, ViewModel 데이터 담기)
 * Service 책임 : 통신하고, 파싱하고, 데이터 관련 처리
 * ViewModel 책임 : 뷰 데이터 상태 관리
 * model 책임 : ViewModel 데이터 전담
 * Provider 책임 : 전역 뷰 관련 상태 관리
 * static 클래스 : 전역 데이터 관리 (세션 같은 것)
 */

final userController = Provider<UserController>((ref) {
  return UserController(ref);
});

class UserController {
  final mContext = navigatorKey.currentContext;
  final UserService userService = UserService();
  final Ref _ref;

  UserController(this._ref);

  Future<void> moveLoginPage() async {
    Navigator.popAndPushNamed(mContext!, Move.loginPage);
  }

  Future<void> moveJoinPage() async {
    Navigator.popAndPushNamed(mContext!, Move.joinPage);
  }

  Future<void> join(
      {required String username,
      required String password,
      required String email}) async {
    // 1. DTO 변환
    JoinReqDto joinReqDto =
        JoinReqDto(username: username, password: password, email: email);

    // 2. 통신 요청
    ResponseDto responseDto = await userService.fetchJoin(joinReqDto);

    // 3. 비지니스 로직 처리
    if (responseDto.code == 1) {
      Navigator.popAndPushNamed(mContext!, Move.loginPage);
      // 4. 응답된 데이터를 ViewModel에 반영해야 한다면 통신 성공시에 추가하기
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("회원가입 실패")),
      );
    }
  }

  Future<void> login(
      {required String username, required String password}) async {
    // 1. DTO 변환
    LoginReqDto loginReqDto =
        LoginReqDto(username: username, password: password);

    // 2. 통신 요청
    ResponseDto responseDto = await userService.fetchLogin(loginReqDto);
    //3. 비지니스 로직 처리
    if (responseDto.code == 1) {
      Navigator.of(navigatorKey.currentContext!)
          .pushNamedAndRemoveUntil(Move.homePage, (route) => false);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("로그인 실패")),
      );
    }
  }

  Future<void> logout() async {
    await UserSession.removeAuthentication();
    await Navigator.of(navigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(Move.loginPage, (route) => false);
  }

  void moveUserInfoPage() {
    Navigator.pushNamed(mContext!, Move.userInfoPage);
  }
}
