import 'package:blog/controller/post_controller.dart';
import 'package:blog/controller/user_controller.dart';
import 'package:blog/core/constant/move.dart';
import 'package:blog/core/util/validator_util.dart';
import 'package:blog/provider/auth_provider.dart';
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
    ref.read(authProvider.notifier).autoLogin();
    UserController userCT = ref.read(userController);
    Logger().d("로그인 페이지 빌드 시작");
    return Scaffold(body: _buildBody(context, userCT));
  }

  Widget _buildBody(BuildContext context, UserController userCT) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
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
          _loginForm(context, userCT), // 추가
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context, UserController userCT) {
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
                await userCT.login(
                    username: _username.text.trim(),
                    password: _password.text.trim()); // 추가
              }
            },
          ),
          TextButton(
            onPressed: () {
              userCT.moveJoinPage();
            },
            child: const Text("아직 회원가입이 안되어 있나요?"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Move.homePage, (route) => false);
            },
            child: const Text("홈페이지 로그인 없이 가보는 테스트"),
          ),
        ],
      ),
    );
  }
}
