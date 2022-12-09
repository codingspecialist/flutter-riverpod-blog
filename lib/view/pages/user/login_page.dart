import 'package:blog/controller/user_controller.dart';
import 'package:blog/core/routers.dart';
import 'package:blog/util/validator_util.dart';
import 'package:blog/view/components/custom_elevated_button.dart';
import 'package:blog/view/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Logger().d("로그인 페이지 빌드 시작");
    // 추가
    final uc = ref.read(userController); // 추가
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildList(uc, context),
      ),
    );
  }

  Widget buildList(UserController uc, BuildContext context) {
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
        _loginForm(uc, context), // 추가
      ],
    );
  }

  Widget _loginForm(UserController uc, BuildContext context) {
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
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routers.home);
            },
            child: const Text("홈페이지 로그인 없이 가보는 테스트"),
          ),
        ],
      ),
    );
  }
}
