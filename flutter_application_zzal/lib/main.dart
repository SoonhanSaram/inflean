import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/view/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> args) {
  runApp(const ProviderScope(child: _App()));
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
