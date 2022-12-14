import 'package:blog/core/constant/move.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/model/post.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/detail_page/model/detail_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final detailPageViewModel = StateNotifierProvider.family
    .autoDispose<DetailPageViewModel, DetailPageModel?, int>((ref, postId) {
  return DetailPageViewModel(null, postId)..notifyViewModel();
});

class DetailPageViewModel extends StateNotifier<DetailPageModel?> {
  final PostService postService = PostService();
  final int postId; // param
  final mContext = navigatorKey.currentContext;
  DetailPageViewModel(super.state, this.postId);

  Future<void> notifyViewModel() async {
    ResponseDto responseDto = await postService.fetchPost(postId);
    if (responseDto.code == 1) {
      state = DetailPageModel(responseDto.data);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("잘못된 요청입니다.")),
      );
    }
  }

  void notifyUpdate(Post post) {
    state = DetailPageModel(post);
  }
}
