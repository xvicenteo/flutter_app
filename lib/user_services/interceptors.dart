import 'package:dio/dio.dart';
import 'package:flutterapps/user_services/storage.dart';
import 'package:flutterapps/user_services/auth_controller.dart';
import 'package:flutterapps/main.dart';

class DioInterceptor extends Interceptor {

  final Dio dio = Dio();
  final secureStorage = SecureStorageService();
  final authController = AuthController();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorage.readToken('token');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler  handler) async {

    if(err.response?.statusCode == 401) {
      final refresh = await secureStorage.readToken('refresh');
      if(refresh != null && refresh.isNotEmpty) {
        if (await authController.refreshToken(refresh!)) {
          final token = await secureStorage.readToken('token');
          err.requestOptions.headers['Authorization'] = 'Bearer $token';
          return handler.resolve(await _retry(err.requestOptions));
        }
      }
      secureStorage.deleteTokens();
      navKey.currentState?.pushNamed('/Login');


    }
    // super.onError(err, handler);
  }

  Future <Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options);
  }
}



class DioInterceptorLogin extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }

}