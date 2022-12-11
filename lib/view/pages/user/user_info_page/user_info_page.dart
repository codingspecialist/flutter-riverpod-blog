import 'package:blog/view/pages/user/user_info_page/model/user_info_page_model.dart';
import 'package:blog/view/pages/user/user_info_page/model/user_info_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class UserInfoPage extends ConsumerWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserInfoPageModel? model = ref.watch(userInfoPageViewModel);
    Logger().d("UserInfoPage");
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(model),
    );
  }

  Widget _buildBody(UserInfoPageModel? model) {
    if (model == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("회원 번호 : ${model.user.id}"),
            Text("회원 유저네임 : ${model.user.username}"),
            Text("회원 이메일 : ${model.user.email}"),
            Text("회원 가입날짜 : ${model.user.created}"),
          ],
        ),
      );
    }
  }
}
