import 'package:flutter/material.dart';

import 'login/view/login_view.dart';
import 'shared_prefrences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.prefrencesInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopGo Case',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
