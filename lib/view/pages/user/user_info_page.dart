import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d("UserInfoPage");
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("회원 번호 : 1"),
          Text("회원 유저네임 : ssar"),
          Text("회원 이메일 : ssar@nate.com"),
          Text("회원 가입날짜 : 2022.12.09"),
        ],
      ),
    );
  }
}
