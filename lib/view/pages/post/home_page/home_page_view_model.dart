import 'package:blog/domain/post/post.dart';
import 'package:blog/domain/post/post_service.dart';
import 'package:blog/dto/response_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageViewModel =
    StateNotifierProvider.autoDispose<HomePageViewModel, List<Post>>((ref) {
  return HomePageViewModel([])..initViewModel();
});

class HomePageViewModel extends StateNotifier<List<Post>> {
  HomePageViewModel(super.state);

  Future<void> initViewModel() async {
    ResponseDto responseDto = await PostService().findAll();
    List<dynamic> mapList = responseDto.data; // dynamic
    List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();
    state = postList;
  }
}
