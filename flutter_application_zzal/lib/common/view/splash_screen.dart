import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/const/colors.dart';
import 'package:flutter_application_zzal/common/const/data.dart';
import 'package:flutter_application_zzal/common/layout/defalut_layout.dart';
import 'package:flutter_application_zzal/common/view/root_tab.dart';
import 'package:flutter_application_zzal/user/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // deleteToken();
    checkToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final dio = Dio();

    try {
      final response = await dio.post(
        'http://$ip/auth/token',
        options: Options(
          headers: {'authorization': 'Bearer $refreshToken'},
        ),
      );

      await storage.write(
        key: ACCESS_TOKEN_KEY,
        value: response.data['accessToken'],
      );

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const RootTab(),
          ),
          (route) => false);
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 16.0),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ]),
        ));
  }
}
