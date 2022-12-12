import 'package:blog/core/constant/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await LocalService().fetchJwtToken();
//   // 자동 로그인시 필요
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: navigatorKey,
//       debugShowCheckedModeBanner: false,
//       initialRoute: UserSession.isLogin ? Move.homePage : Move.loginPage,
//       routes: getRouters(),
//     );
//   }
// }

void main() {
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
      initialRoute: Move.loginPage,
      routes: getRouters(),
    );
  }
}
