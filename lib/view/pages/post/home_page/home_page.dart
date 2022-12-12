import 'package:blog/controller/post_controller.dart';
import 'package:blog/core/constant/move.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:blog/view/components/custom_navigation.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_model.dart';
import 'package:blog/view/pages/post/home_page/model/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostController postCT = ref.read(postController);

    return Scaffold(
      key: scaffoldKey,
      drawer: CustomNavigation(scaffoldKey),
      appBar: AppBar(title: const Text("home page")),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          postCT.refreshHomePage();
        },
        child: _buildBody(postCT),
      ),
    );
  }

  Widget _buildBody(PostController postCT) {
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
                onTap: () {
                  postCT.moveDetailPage(model.posts[index].id);
                },
                child: ListTile(
                  leading: Text("${model.posts[index].id}"),
                  title: Text(model.posts[index].content),
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
