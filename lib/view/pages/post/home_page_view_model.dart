import 'package:blog/domain/post/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageViewModel =
    StateNotifierProvider.autoDispose<HomePageViewModel, List<Post>>((ref) {
  return HomePageViewModel([])..initViewModel();
});

class HomePageViewModel extends StateNotifier<List<Post>> {
  HomePageViewModel(super.state);

  void initViewModel() {
    // repository 접근해서 값 받아와서 state에 저장
  }
}
