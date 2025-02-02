import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/view/splash_screen.dart';
import 'package:flutter_application_zzal/user/view/login_screen.dart';

void main(List<String> args) {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'NotoSans'),
        home: const SplashScreen());
  }
}
