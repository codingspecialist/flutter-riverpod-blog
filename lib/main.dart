import 'package:blog/core/routers.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:blog/view/pages/post/detail_page.dart';
import 'package:blog/view/pages/post/home_page.dart';
import 'package:blog/view/pages/post/update_page.dart';
import 'package:blog/view/pages/post/write_page.dart';
import 'package:blog/view/pages/user/join_page.dart';
import 'package:blog/view/pages/user/login_page.dart';
import 'package:blog/view/pages/user/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

void main() async {
  // 자동 로그인시 필요
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    AuthProvider ap = ref.read(authProvider);

    return FutureBuilder(
      future: ap.initJwtToken(),
      builder: (context, snapshot) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: snapshot.data! ? Routers.home : Routers.loginForm,
          routes: getRouters(),
        );
      },
    );
  }
}
