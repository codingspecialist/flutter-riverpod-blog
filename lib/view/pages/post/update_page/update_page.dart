import 'package:blog/core/util/validator_util.dart';
import 'package:blog/view/components/custom_elevated_button.dart';
import 'package:blog/view/components/custom_text_form_field.dart';
import 'package:blog/view/components/custom_textarea.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UpdatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d("UpdatePage");
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
            // homepage -> detailpage -> detailpage
            CustomElevatedButton(
              text: "글 수정하기",
              funPageRoute: () async {
                if (_formKey.currentState!.validate()) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
