import 'package:blog/domain/post/post.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageViewModel =
    StateNotifierProvider.autoDispose<HomePageViewModel, List<Post>>((ref) {
  AuthProvider ap = ref.read(authProvider);
  return HomePageViewModel([], ap)..initViewModel();
});

class HomePageViewModel extends StateNotifier<List<Post>> {
  AuthProvider ap;
  HomePageViewModel(super.state, this.ap);

  void initViewModel() {
    // repository 접근해서 값 받아와서 state에 저장
  }
}
