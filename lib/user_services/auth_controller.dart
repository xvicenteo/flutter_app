import 'package:flutter/material.dart';
import 'package:flutterapps/user_services/interceptors.dart';
import 'package:flutterapps/user_services/storage.dart';
import 'package:dio/dio.dart';

import 'package:flutterapps/pages/home.dart';

class AuthController {
  late final Dio _dio;
  final secureStorage = SecureStorageService();

  AuthController() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptorLogin());
  }

  Future loginUser(BuildContext context, String username, String password) async {
    const url = 'http://10.10.110.74:8005/rest/v1/token/';

    final response = await _dio.post(url, data: {
      "username": username,
      "password": password
    });

    if(response.statusCode == 200) {
      await secureStorage.writeToken('token', response.data['access']);
      await secureStorage.writeToken('refresh', response.data['refresh']);

      if(!context.mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));

    } else {
      print('error login');
    }
  }

  Future refreshToken (String refreshToken) async{

    const refreshUrl = "http://10.10.110.74:8005/rest/v1/token/refresh/";
    var refreshToken = await secureStorage.readToken('refresh');

    final response = await _dio.post(refreshUrl, data: {
      "refresh": refreshToken
    });

    if (response.statusCode == 200) {
      final newAccessToken = response.data['access'];
      await secureStorage.writeToken('token', newAccessToken);
      return true;
    } else {
      await secureStorage.deleteTokens();

      return false;
    }

  }


  void cleanTokens() async {
    await secureStorage.deleteTokens();
  }

}

