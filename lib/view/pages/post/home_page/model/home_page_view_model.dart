import 'package:blog/core/constant/move.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/post.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
 * 메서드 이름 규칙 : 동사+명사
 * 메서드 이름 짓는 법 : 컨트롤러에서 변경된 값을 반영하는 것이기 떄문에
 * notify + 동사
 * 화면 진입시에 초기화 메서드는 notifyViewModel 이름 정함.
 */

final homePageViewModel =
    StateNotifierProvider.autoDispose<HomePageViewModel, HomePageModel?>((ref) {
  return HomePageViewModel(null)..notifyViewModel();
});

class HomePageViewModel extends StateNotifier<HomePageModel?> {
  final PostService postService = PostService();
  final mContext = navigatorKey.currentContext;
  HomePageViewModel(super.state);

  Future<void> notifyViewModel() async {
    ResponseDto responseDto = await postService.fetchPostList();
    if (responseDto.code == 1) {
      state = HomePageModel(responseDto.data);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("Jwt 토큰이 만료되었습니다. 로그인 페이지로 이동합니다.")),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
            mContext!, Move.loginPage, (route) => false);
      });
    }
  }

  // state를 변경해야함. 그 안에 내용을 별개로 변경한다고 뷰에 반영안됨.
  void notifyDelete(int postId) {
    List<Post> posts = state!.posts.where((e) => e.id != postId).toList();
    state = HomePageModel(posts);
  }

  void notifyAdd(Post post) {
    List<Post> posts = [post, ...state!.posts];
    state = HomePageModel(posts);
  }

  void notifyUpdate(Post post) {
    List<Post> posts =
        state!.posts.map((e) => e.id == post.id ? post : e).toList();
    state = HomePageModel(posts);
  }
}
