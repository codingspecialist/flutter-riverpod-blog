import 'package:blog/core/constant/routers.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/post.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final homePageViewModel =
    StateNotifierProvider.autoDispose<HomePageViewModel, HomePageModel?>((ref) {
  return HomePageViewModel(null)..initViewModel();
});

class HomePageViewModel extends StateNotifier<HomePageModel?> {
  final PostService postService = PostService();
  final mContext = navigatorKey.currentContext;
  HomePageViewModel(super.state);

  Future<void> initViewModel() async {
    ResponseDto responseDto = await postService.findAll();
    if (responseDto.code == 1) {
      state = HomePageModel(responseDto.data);
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

  // state를 변경해야함. 그 안에 내용을 별개로 변경한다고 뷰에 반영안됨.
  void deletePost(int postId) {
    List<Post> result =
        state!.posts.where((post) => post.id != postId).toList();
    state = HomePageModel(result);
  }
}
