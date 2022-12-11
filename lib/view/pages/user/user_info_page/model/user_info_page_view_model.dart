import 'package:blog/core/constant/routers.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/user_session.dart';
import 'package:blog/service/user_service.dart';
import 'package:blog/view/pages/user/user_info_page/model/user_info_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// autoDispose 를 안해주면, 다른 아이디로 재로그인 했을 때, ViewModel이 살아있어서 데이터를 이전 것을 가져온다.
final userInfoPageViewModel = StateNotifierProvider.autoDispose<
    UserInfoPageViewModel, UserInfoPageModel?>((ref) {
  return UserInfoPageViewModel(null)..initViewModel();
});

class UserInfoPageViewModel extends StateNotifier<UserInfoPageModel?> {
  final UserService userService = UserService();
  final mContext = navigatorKey.currentContext;
  UserInfoPageViewModel(super.state);

  Future<void> initViewModel() async {
    Logger().d("user id : ${UserSession.user!.id}");
    ResponseDto responseDto = await userService.findById(UserSession.user!.id);
    if (responseDto.code == 1) {
      state = UserInfoPageModel(responseDto.data);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("잘못된 요청입니다.")),
      );
    }
  }
}
