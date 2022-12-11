import 'package:blog/controller/post_controller.dart';
import 'package:blog/view/pages/post/detail_page/model/detail_page_model.dart';
import 'package:blog/view/pages/post/detail_page/model/detail_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  final int postId;
  const DetailPage(this.postId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailPageModel? model = ref.watch(detailPageViewModel(postId));
    PostController postCT = ref.read(postController);

    return Scaffold(
      appBar: AppBar(),
      body: model == null
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(model, postCT),
    );
  }

  Widget _buildBody(DetailPageModel model, PostController postCT) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.post.content,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          const Divider(),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  postCT.deletePost(model.post.id);
                },
                child: const Text("삭제"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text("수정"),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(model.post.title),
            ),
          ),
        ],
      ),
    );
  }
}
