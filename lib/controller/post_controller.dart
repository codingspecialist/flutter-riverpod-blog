import 'package:blog/core/constant/routers.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/detail_page/detail_page.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final postController = Provider<PostController>((ref) {
  return PostController(ref);
});

class PostController {
  final mContext = navigatorKey.currentContext;
  final Ref _ref;
  PostController(this._ref);

  PostService postService = PostService();

  Future<void> refreshPage() async {
    _ref.read(homePageViewModel.notifier).initViewModel();
  }

  void moveDetail(int postId) {
    Navigator.push(
      mContext!,
      MaterialPageRoute(
        builder: (context) => DetailPage(postId),
      ),
    );
  }

  void moveWriteForm() {
    Navigator.pushNamed(mContext!, Routers.writeForm);
  }

  void deletePost(int postId) async {
    ResponseDto responseDto = await postService.deleteById(postId);
    if (responseDto.code == 1) {
      Logger().d("게시글 삭제 성공 : ${postId}");
      _ref.read(homePageViewModel.notifier).deletePost(postId);
      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text("게시글 삭제 실패 : ${responseDto.msg}")),
      );
    }
  }
}
