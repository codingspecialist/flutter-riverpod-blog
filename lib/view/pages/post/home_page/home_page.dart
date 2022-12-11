import 'package:blog/controller/user_controller.dart';
import 'package:blog/core/constant/routers.dart';
import 'package:blog/core/constant/size.dart';
import 'package:blog/model/user_session.dart';
import 'package:blog/view/components/custom_navigation.dart';
import 'package:blog/view/pages/post/home_page/home_page_view_model.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    Logger().d("homePage 빌드");

    return Scaffold(
      drawer: const CustomNavigation(),
      appBar: AppBar(
          title: Text(
              "로그인한 유저 토큰 : ${UserSession.user == null ? "없음" : UserSession.user!.username}")),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {},
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    Logger().d("Consumer _buildBody 실행");
    return Consumer(
      builder: (context, ref, child) {
        HomePageModel? model = ref.watch(homePageViewModel);
        if (model == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          Logger().d("model 생성됨 실행 : ${model.posts.length}");
          return ListView.separated(
            itemCount: model.posts.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Text("${model.posts[index].id}"),
                  title: Text("${model.posts[index].content}"),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        }
      },
    );
  }
}
