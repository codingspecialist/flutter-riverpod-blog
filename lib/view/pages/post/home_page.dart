import 'package:blog/controller/user_controller.dart';
import 'package:blog/core/constant/routers.dart';
import 'package:blog/core/constant/size.dart';
import 'package:blog/domain/local/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  final scaffodKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Logger().d("homePage 빌드");

    return Scaffold(
      drawer: _navigation(),
      appBar: AppBar(
          title: Text(
              "로그인한 유저 토큰 : ${UserModel.user == null ? "없음" : UserModel.user!.username}")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: () async {},
      child: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: const ListTile(
              leading: Text("아이디"),
              title: Text("제목"),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _navigation() {
    return Container(
      width: getDrawerWidth(context),
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
                  Navigator.pushNamed(context, Routers.writeForm);
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
                  Navigator.pushNamed(context, Routers.userInfo);
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
