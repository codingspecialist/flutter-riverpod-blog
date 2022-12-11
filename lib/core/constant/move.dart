import 'package:blog/view/pages/post/home_page/home_page.dart';
import 'package:blog/view/pages/post/write_page/write_page.dart';
import 'package:blog/view/pages/user/join_page/join_page.dart';
import 'package:blog/view/pages/user/login_page/login_page.dart';
import 'package:blog/view/pages/user/user_info_page/user_info_page.dart';
import 'package:flutter/cupertino.dart';

class Move {
  static String homePage = "/homePage";
  static String writePage = "/writePage";
  static String joinPage = "/joinPage";
  static String loginPage = "/loginPgae";
  static String userInfoPage = "/userInfoPage";
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Map<String, Widget Function(BuildContext)> getRouters() {
  return {
    Move.joinPage: (context) => JoinPage(),
    Move.loginPage: (context) => LoginPage(),
    Move.homePage: (context) => HomePage(),
    Move.writePage: (context) => WritePage(),
    Move.userInfoPage: (context) => const UserInfoPage(),
  };
}
