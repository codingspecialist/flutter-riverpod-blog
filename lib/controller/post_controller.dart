import 'package:blog/core/constant/routers.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/detail_page/detail_page.dart';
import 'package:blog/view/pages/post/detail_page/model/detail_page_model.dart';
import 'package:blog/view/pages/post/detail_page/model/detail_page_view_model.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postController = Provider<PostController>((ref) {
  return PostController(ref);
});

class PostController {
  final mContext = navigatorKey.currentContext;
  final Ref _ref;
  PostController(this._ref);

  PostService postService = PostService();

  Future<void> findAll() async {
    _ref.read(homePageViewModel.notifier).refresh();
  }

  void moveDetail(int postId) {
    // 파라메터 전달
    // _ref.read(detailPageViewModel(postId).notifier);
    // // 화면 이동
    // Navigator.pushNamed(mContext!, Routers.detail);

    Navigator.push(
      mContext!,
      MaterialPageRoute(
        builder: (context) => DetailPage(postId),
      ),
    );
  }
}
