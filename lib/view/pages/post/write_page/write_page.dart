import 'package:blog/controller/post_controller.dart';
import 'package:blog/core/util/validator_util.dart';
import 'package:blog/view/components/custom_elevated_button.dart';
import 'package:blog/view/components/custom_text_form_field.dart';
import 'package:blog/view/components/custom_textarea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WritePage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  WritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostController postCT = ref.read(postController);
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(postCT),
    );
  }

  Widget _buildBody(PostController postCT) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            CustomTextFormField(
              controller: _title,
              hint: "Title",
              funValidator: validateTitle(),
            ),
            CustomTextArea(
              controller: _content,
              hint: "Content",
              funValidator: validateContent(),
            ),
            CustomElevatedButton(
              text: "글쓰기",
              funPageRoute: () async {
                if (_formKey.currentState!.validate()) {
                  postCT.writePost(
                      title: _title.text.trim(), content: _content.text.trim());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
