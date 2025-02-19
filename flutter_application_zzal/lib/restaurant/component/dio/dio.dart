// 인터셉트

import 'package:dio/dio.dart';
import 'package:flutter_application_zzal/common/const/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청을 보낼 때
  // 요청이 보내질 때마다
  // 요청의 Header 에 accessToken 이 true 일 때
  // storage 에서 ACCESS_TOKEN_KEY 를 가져와 authorization 에 담아준다.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');
    print('Request Headers: ${options.headers}');
    if (options.headers['accessToken'] == 'true') {
      print('accessToken true');
      // Header 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 Token 으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      print('refreshToken true');

      // Header 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 Token 으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }
    print('options.headers');
    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을 때

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '[REQ] [${response.requestOptions.method}] ${response.requestOptions.uri}',
    );

    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을 때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401에러가 났을 때 (status code)
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    // 다시 새로운 토큰을 요청한다.
    print('err');
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken 이 없으면 error 던진다.
    if (refreshToken == null) {
      //  에러를 던질 때는 handler.reject 를 사용한다.
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final response = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = response.data['accessToken'];

        final options = err.requestOptions;

        // 토큰 변경
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await storage.write(key: 'ACCESS_TOKEN_KEY', value: accessToken);

        // 요청 재전송
        final response2 = await dio.fetch(options);

        return handler.resolve(response2);
      } on DioException catch (e) {
        return handler.reject(err);
      }
    }

    return super.onError(err, handler);
  }
}
