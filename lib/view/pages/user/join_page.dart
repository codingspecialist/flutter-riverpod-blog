import 'package:blog/controller/user_controller.dart';
import 'package:blog/util/validator_util.dart';
import 'package:blog/view/components/custom_elevated_button.dart';
import 'package:blog/view/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinPage extends ConsumerWidget {
  // 추가
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController(); // 추가
  final _password = TextEditingController(); // 추가
  final _email = TextEditingController(); // 추가

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 추가
    final uc = ref.read(userController); // 추가

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                "회원가입 페이지",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _joinForm(uc), // 추가
          ],
        ),
      ),
    );
  }

  Widget _joinForm(UserController uc) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _username, // 추가
            hint: "Username",
            funValidator: validateUsername(),
          ),
          CustomTextFormField(
            controller: _password, // 추가
            hint: "Password",
            funValidator: validatePassword(),
          ),
          CustomTextFormField(
            controller: _email, // 추가
            hint: "Email",
            funValidator: validateEmail(),
          ),
          CustomElevatedButton(
            text: "회원가입",
            funPageRoute: () {
              if (_formKey.currentState!.validate()) {
                // 추가
                uc.join(
                    username: _username.text.trim(),
                    password: _password.text.trim(),
                    email: _email.text.trim());
              }
            },
          ),
          TextButton(
            onPressed: () {
              uc.loginForm(); // 추가
            },
            child: Text("로그인 페이지로 이동"),
          ),
        ],
      ),
    );
  }
}
