import 'package:blog/core/size.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:blog/view/pages/post/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var scaffodKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Logger().d("homePage 빌드");
    final hvm = ref.watch(homePageViewModel.notifier);

    return Scaffold(
      key: scaffodKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (scaffodKey.currentState!.isDrawerOpen) {
            scaffodKey.currentState!.openEndDrawer();
          } else {
            scaffodKey.currentState!.openDrawer();
          }
        },
        child: Icon(Icons.code),
      ),
      drawer: _navigation(context),
      appBar: AppBar(
        title: _buildAppBarTitle(hvm),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {},
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: ListTile(
                leading: Text("아이디"),
                title: Text("제목"),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }

  Widget _buildAppBarTitle(HomePageViewModel hvm) {
    if (hvm.ap.isLogin) {
      return Text("로그인한 유저 토큰 : ${hvm.ap.jwtToken}");
    } else {
      return Text("로그인 되지 않은 상태입니다.");
    }
  }

  Widget _navigation(BuildContext context) {
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
                onPressed: () {},
                child: Text(
                  "글쓰기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  //Navigator.pop(context);
                  scaffodKey.currentState!.openEndDrawer();
                },
                child: Text(
                  "회원정보보기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {},
                child: Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
