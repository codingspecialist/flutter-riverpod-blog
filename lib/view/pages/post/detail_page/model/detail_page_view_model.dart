import 'package:blog/core/constant/routers.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:blog/service/post_service.dart';
import 'package:blog/view/pages/post/detail_page/model/detail_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final detailPageViewModel = StateNotifierProvider.family
    .autoDispose<DetailPageViewModel, DetailPageModel?, int>((ref, postId) {
  return DetailPageViewModel(null, postId)..refresh();
});

class DetailPageViewModel extends StateNotifier<DetailPageModel?> {
  final PostService postService = PostService();
  final int postId;
  final mContext = navigatorKey.currentContext;
  DetailPageViewModel(super.state, this.postId);

  Future<void> refresh() async {
    ResponseDto responseDto = await postService.findById(postId);
    if (responseDto.code == 1) {
      DetailPageModel detailPageModel = DetailPageModel(responseDto.data);
      state = detailPageModel;
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        const SnackBar(content: Text("잘못된 요청입니다.")),
      );
    }
  }
}