import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_zzal/common/component/custom_text_form_field.dart';
import 'package:flutter_application_zzal/common/const/colors.dart';
import 'package:flutter_application_zzal/common/const/data.dart';
import 'package:flutter_application_zzal/common/layout/defalut_layout.dart';
import 'package:flutter_application_zzal/common/view/root_tab.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    final dio = Dio();

    return DefaultLayout(
        child: SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Title(),
              const SizedBox(height: 16.0),
              const _SubTitle(),
              Image.asset(
                'asset/img/misc/logo.png',
                width: MediaQuery.of(context).size.width / 3 * 2,
              ),
              CustomTextFoamField(
                onChanged: (String value) {
                  username = value;
                },
                hintText: '이메일을 입력해주세요.',
              ),
              const SizedBox(height: 16.0),
              CustomTextFoamField(
                obscureText: true,
                onChanged: (String value) {
                  password = value;
                },
                hintText: '비밀번호를 입력해주세요요',
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: () async {
                    final rawString = '$username:$password';

                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode(rawString);

                    final response = await dio.post('http://$ip/auth/login',
                        options: Options(headers: {
                          'authorization': 'Basic $token',
                        }));
                    final refreshToken = response.data['refreshToken'];
                    final accessToken = response.data['accessToken'];

                    await storage.write(
                        key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(
                        key: ACCESS_TOKEN_KEY, value: accessToken);

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const RootTab()));

                    print(response.data);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                  child: const Text('로그인')),
              TextButton(
                onPressed: () async {
                  const represhToken =
                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTczODI1MjUwNiwiZXhwIjoxNzM4MzM4OTA2fQ.FYBdqy1AOoVoaIyU7Ho-3Om72VFPFWbWHepli8Omx4o';
                  final response = await dio.post('http://$ip/auth/token',
                      options: Options(headers: {
                        'authorization': 'Bearer $represhToken',
                      }));

                  print(response.data);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: const Text('회원가입'),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다.',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

// ackii 에서는 \n 줄바꿈

class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인해주세요! \n 오늘도 성공적인 주문이 되길^^',
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
