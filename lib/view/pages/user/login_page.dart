import 'package:blog/controller/user_controller.dart';
import 'package:blog/util/validator_util.dart';
import 'package:blog/view/components/custom_elevated_button.dart';
import 'package:blog/view/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 추가
    final uc = ref.read(userController); // 추가
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildList(uc),
      ),
    );
  }

  Widget buildList(UserController uc) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          height: 200,
          child: const Text(
            "로그인 페이지",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _loginForm(uc), // 추가
      ],
    );
  }

  Widget _loginForm(UserController uc) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _username,
            hint: "Username",
            funValidator: validateUsername(),
          ),
          CustomTextFormField(
            controller: _password,
            hint: "Password",
            funValidator: validatePassword(),
          ),
          CustomElevatedButton(
            text: "로그인",
            funPageRoute: () async {
              if (_formKey.currentState!.validate()) {
                uc.login(
                    username: _username.text.trim(),
                    password: _password.text.trim()); // 추가
              }
            },
          ),
          TextButton(
            onPressed: () {
              uc.joinForm();
            },
            child: const Text("아직 회원가입이 안되어 있나요?"),
          ),
        ],
      ),
    );
  }
}
