import 'package:blog/core/constant/routers.dart';
import 'package:blog/dto/post_req_dto.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/post.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/detail_page/detail_page.dart';
import 'package:blog/view/pages/post/detail_page/model/detail_page_view_model.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_view_model.dart';
import 'package:blog/view/pages/post/update_page/update_page.dart';
import 'package:flutter/gestures.dart';
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

  void moveUpdateForm(Post post) {
    Navigator.push(
      mContext!,
      MaterialPageRoute(
        builder: (context) => UpdatePage(post),
      ),
    );
  }

  void deletePost(int postId) async {
    ResponseDto responseDto = await postService.deleteById(postId);
    if (responseDto.code == 1) {
      Logger().d("게시글 삭제 성공 : $postId");
      _ref.read(homePageViewModel.notifier).deletePost(postId);
      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text("게시글 삭제 실패 : ${responseDto.msg}")),
      );
    }
  }

  Future<void> write({required String title, required String content}) async {
    PostWriteReqDto postWriteReqDto =
        PostWriteReqDto(title: title, content: content);
    ResponseDto responseDto = await postService.write(postWriteReqDto);
    if (responseDto.code == 1) {
      _ref.read(homePageViewModel.notifier).addPost(responseDto.data);
      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text("게시글 쓰기 실패 : ${responseDto.msg}")),
      );
    }
  }

  Future<void> update(
      {required int id, required String title, required String content}) async {
    PostUpdateReqDto postUpdateReqDto =
        PostUpdateReqDto(title: title, content: content);
    ResponseDto responseDto = await postService.update(id, postUpdateReqDto);
    if (responseDto.code == 1) {
      // detail page 반영
      _ref.read(detailPageViewModel(id).notifier).updatePost(responseDto.data);
      // home page 반영
      _ref.read(homePageViewModel.notifier).updatePost(responseDto.data);

      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(content: Text("게시글 수정 실패 : ${responseDto.msg}")),
      );
    }
  }
}
