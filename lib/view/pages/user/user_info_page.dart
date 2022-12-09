import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("회원 번호 : 1"),
            Text("회원 유저네임 : ssar"),
            Text("회원 이메일 : ssar@nate.com"),
            Text("회원 가입날짜 : 2022.12.09"),
          ],
        ),
      ),
    );
  }
}
