import 'package:blog/core/constant/move.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/session_user.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:blog/service/user_service.dart';
import 'package:blog/view/pages/user/user_info_page/model/user_info_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// autoDispose 를 안해주면, 다른 아이디로 재로그인 했을 때, ViewModel이 살아있어서 데이터를 이전 것을 가져온다.
final userInfoPageViewModel = StateNotifierProvider.autoDispose<
    UserInfoPageViewModel, UserInfoPageModel?>((ref) {
  return UserInfoPageViewModel(null, ref)..initViewModel();
});

class UserInfoPageViewModel extends StateNotifier<UserInfoPageModel?> {
  final UserService userService = UserService();
  final mContext = navigatorKey.currentContext;
  final Ref _ref;
  UserInfoPageViewModel(super.state, this._ref);

  Future<void> initViewModel() async {
    SessionUser sessionUser = _ref.read(authProvider);
    ResponseDto responseDto = await userService.fetchUserInfo(
        sessionUser.user.id, sessionUser.jwtToken);
    if (responseDto.code == 1) {
      state = UserInfoPageModel(responseDto.data);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("잘못된 요청입니다.")),
      );
    }
  }
}
