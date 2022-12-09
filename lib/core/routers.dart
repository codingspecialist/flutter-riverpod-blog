import 'package:blog/view/pages/post/detail_page.dart';
import 'package:blog/view/pages/post/home_page.dart';
import 'package:blog/view/pages/post/update_page.dart';
import 'package:blog/view/pages/post/write_page.dart';
import 'package:blog/view/pages/user/join_page.dart';
import 'package:blog/view/pages/user/login_page.dart';
import 'package:blog/view/pages/user/user_info_page.dart';
import 'package:flutter/cupertino.dart';

class Routers {
  static String home = "/home";
  static String detail = "/detail";
  static String updateForm = "/updateForm";
  static String writeForm = "/writeForm";
  static String joinForm = "/joinForm";
  static String loginForm = "/loginForm";
  static String userInfo = "/userInfo";
}

Map<String, Widget Function(BuildContext)> getRouters() {
  return {
    Routers.joinForm: (context) => JoinPage(),
    Routers.loginForm: (context) => LoginPage(),
    Routers.home: (context) => HomePage(),
    Routers.detail: (context) => DetailPage(),
    Routers.updateForm: (context) => UpdatePage(),
    Routers.writeForm: (context) => WritePage(),
    Routers.userInfo: (context) => UserInfoPage(),
  };
}
