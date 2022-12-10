import 'package:blog/controller/user_controller.dart';
import 'package:blog/core/constant/routers.dart';
import 'package:blog/core/constant/size.dart';
import 'package:blog/model/user_session.dart';
import 'package:blog/model/post.dart';
import 'package:blog/view/pages/post/home_page/home_page_view_model.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class HomePage extends StatelessWidget {
  final mContext = navigatorKey.currentContext;
  final refreshKey = GlobalKey<RefreshIndicatorState>(); // 이 친구 때문에
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger().d("homePage 빌드");

    return Scaffold(
      drawer: _navigation(),
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
    return Consumer(
      builder: (context, ref, child) {
        HomePageModel? model = ref.watch(homePageViewModel);
        if (model == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
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

  Widget _navigation() {
    return Container(
      width: getDrawerWidth(mContext!),
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(mContext!, Routers.writeForm);
                },
                child: const Text(
                  "글쓰기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(mContext!, Routers.userInfo);
                },
                child: const Text(
                  "회원정보보기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () async {
                  await UserController().logout();
                },
                child: const Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
