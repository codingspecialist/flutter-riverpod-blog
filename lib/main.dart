import 'package:blog/core/constant/routers.dart';
import 'package:blog/domain/local/local_repository.dart';
import 'package:blog/domain/local/user_session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalRepository().initShardJwtToken();
  // 자동 로그인시 필요
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: UserSession.isLogin ? Routers.home : Routers.loginForm,
      routes: getRouters(),
    );
  }
}
