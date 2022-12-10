import 'package:blog/core/constant/routers.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/home_page/home_page_view_model.dart';
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
}
