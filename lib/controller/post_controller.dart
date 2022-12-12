import 'package:blog/core/constant/move.dart';
import 'package:blog/dto/post_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/post.dart';
import 'package:blog/model/session_user.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/detail_page/detail_page.dart';
import 'package:blog/view/pages/post/detail_page/model/detail_page_view_model.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_view_model.dart';
import 'package:blog/view/pages/post/update_page/update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final postController = Provider<PostController>((ref) {
  return PostController(ref);
});

/*
 * 메서드 이름 규칙 : 동사+명사
 * 메서드 이름 짓는 법 : 뷰에서 요청하는 것이기 때문에 
 * 화면 이동해줘 -> move화면이름
 * 화면 갱신해줘 -> refresh화면이름
 * 서버쪽 요청해서 멀해줘 -> write모델명
 */

class PostController {
  final mContext = navigatorKey.currentContext;
  final Ref _ref;

  PostController(this._ref);

  PostService postService = PostService();

  Future<void> refreshHomePage() async {
    _ref.read(homePageViewModel.notifier).notifyViewModel();
  }

  void moveDetailPage(int postId) {
    Navigator.push(
      mContext!,
      MaterialPageRoute(
        builder: (context) => DetailPage(postId),
      ),
    );
  }

  void moveHomePage() {
    Navigator.of(mContext!)
        .pushNamedAndRemoveUntil(Move.homePage, (route) => false);
  }

  void moveWritePage() {
    Navigator.pushNamed(mContext!, Move.writePage);
  }

  void moveUpdatePage(Post post) {
    Navigator.push(
      mContext!,
      MaterialPageRoute(
        builder: (context) => UpdatePage(post),
      ),
    );
  }

  void deletePost(int postId) async {
    ResponseDto responseDto = await postService.fetchDeletePost(
        postId, _ref.read(authProvider).jwtToken);
    if (responseDto.code == 1) {
      Logger().d("게시글 삭제 성공 : $postId");
      _ref.read(homePageViewModel.notifier).notifyDelete(postId);
      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text("게시글 삭제 실패 : ${responseDto.msg}")),
      );
    }
  }

  Future<void> writePost(
      {required String title, required String content}) async {
    PostWriteReqDto postWriteReqDto =
        PostWriteReqDto(title: title, content: content);
    ResponseDto responseDto = await postService.fetchWritePost(
        postWriteReqDto, _ref.read(authProvider).jwtToken);
    if (responseDto.code == 1) {
      _ref.read(homePageViewModel.notifier).notifyAdd(responseDto.data);
      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text("게시글 쓰기 실패 : ${responseDto.msg}")),
      );
    }
  }

  Future<void> updatePost(
      {required int id, required String title, required String content}) async {
    PostUpdateReqDto postUpdateReqDto =
        PostUpdateReqDto(title: title, content: content);
    ResponseDto responseDto = await postService.fetchUpdatePost(
        id, postUpdateReqDto, _ref.read(authProvider).jwtToken);
    if (responseDto.code == 1) {
      // detail page 반영
      _ref
          .read(detailPageViewModel(id).notifier)
          .notifyUpdate(responseDto.data);
      // home page 반영
      _ref.read(homePageViewModel.notifier).notifyUpdate(responseDto.data);

      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text("게시글 수정 실패 : ${responseDto.msg}")),
      );
    }
  }
}
