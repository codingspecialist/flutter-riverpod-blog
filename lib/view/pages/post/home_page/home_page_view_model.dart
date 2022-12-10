import 'package:blog/core/constant/routers.dart';
import 'package:blog/model/response_model.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final homePageViewModel =
    StateNotifierProvider.autoDispose<HomePageViewModel, HomePageModel?>((ref) {
  return HomePageViewModel(null)..refresh();
});

class HomePageViewModel extends StateNotifier<HomePageModel?> {
  final mContext = navigatorKey.currentContext;
  HomePageViewModel(super.state);

  // 화면 로직 처리는 컨트롤러인데, refresh만 예외이다.
  Future<void> refresh() async {
    ResponseModel responseModel = await PostService().findAll();
    if (responseModel.code == 1) {
      Logger().d("refresh code : ${responseModel.code}");
      HomePageModel homePageModel = HomePageModel(responseModel.data);
      state = homePageModel;
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("Jwt 토큰이 만료되었습니다. 로그인 페이지로 이동합니다.")),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
            mContext!, Routers.loginForm, (route) => false);
      });
    }
  }
}
